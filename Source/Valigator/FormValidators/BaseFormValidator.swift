//
//  BaseFormValidator.swift
//  Valigator
//

import Foundation

/**
 This is an abstract Form Validator class where validation strategy irrelevant methods are implemented.

 Strategy related methods:
 - func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper]
 - func notifyValidationDelegate(validatableFields: [FieldValidationWrapper])
 - func validatableCrossFieldsBy(validatableFields: [FieldValidationWrapper]) -> [CrossFieldValidationRule]
 */
class BaseFormValidator: FormValidatorProtocol {
    // MARK: - Properties

    public var fields = [FieldValidationWrapper]()
    public var crossFields = [CrossFieldValidationRule]()
    private let validationQueue = OperationQueue()

    // MARK: - FormValidatorProtocol properties

    weak var delegate: FormValidatorDelegate?
    weak var dataSource: FormValidatorDataSource?
    var isAllFieldValid: Bool {
        let validatableFields = fields.filter({ $0.fieldValidation.isEnabled })
        return !validatableFields.contains(where: { $0.fieldValidationState == .invalid || $0.fieldValidationState == .neverValidated })
    }

    // MARK: - Initialization

    init(delegate: FormValidatorDelegate?, dataSource: FormValidatorDataSource?) {
        self.delegate = delegate
        self.dataSource = dataSource

        validationQueue.maxConcurrentOperationCount = 1
    }

    // MARK: - FormValidatorProtocol

    public func registerField(_ field: FieldValidationProtocol) {
        let index = fields.count
        registerField(field, at: index)
    }

    public func registerField(_ field: FieldValidationProtocol, before beforeId: Int) -> Bool {
        guard let neighborIndex = fields.firstIndex(where: { $0.fieldValidation.fieldId == beforeId }) else {
            return false
        }

        registerField(field, at: neighborIndex)
        return true
    }

    public func registerField(_ field: FieldValidationProtocol, after afterId: Int) -> Bool {
        guard let neighborIndex = fields.firstIndex(where: { $0.fieldValidation.fieldId == afterId }) else {
            return false
        }

        let index = neighborIndex + 1
        registerField(field, at: index)

        return true
    }

    public func registerCrossFieldValidationRule(crossFieldValidationRule: CrossFieldValidationRule) {
        crossFields.append(crossFieldValidationRule)
    }

    public func validateFieldBy(id: Int) {
        let validatableFields = fields.filter({ $0.fieldValidation.fieldId == id && $0.fieldValidation.isEnabled })
        validate(validatableFields: validatableFields, allValidatedManually: false)
    }

    public func validateFieldBy(index: Int) {
        var validatableFields = [FieldValidationWrapper]()
        if fields.indices.contains(index), let field = fields[safe: index], field.fieldValidation.isEnabled {
            validatableFields.append(field)
        }
        validate(validatableFields: validatableFields, allValidatedManually: false)
    }

    public func validateAllField() {
        let validatableFields = fields.filter({ $0.fieldValidation.isEnabled })
        validate(validatableFields: validatableFields, allValidatedManually: true)
    }

    public func fieldEditStateDidChangeFor(fieldId: Int, state: FieldEditState) {
        guard let field = fields.first(where: { $0.fieldValidation.fieldId == fieldId }) else {
            assertionFailure("Unregistered field with id: \(fieldId)")
            return
        }

        field.fieldEditState = state
        let validatableFields = validatableFieldsAfterEditStateChanged(for: fieldId)
        validate(validatableFields: validatableFields, allValidatedManually: false)
    }

    public func validate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool) {
        if allValidatedManually {
            validationQueue.cancelAllOperations()
        }

        let validatableCrossFields = validatableCrossFieldsBy(validatableFields: validatableFields)

        let completionOperation = BlockOperation { [weak self] in
            self?.notifyValidationDelegate(validatableFields: validatableFields, allValidatedManually: allValidatedManually)
        }

        validatableFields.forEach { field in
            let operation = BlockOperation {
                DispatchQueue.main.async {
                    field.fieldValidation.validateField()
                }
            }
            completionOperation.addDependency(operation)
            validationQueue.addOperation(operation)
        }

        validatableCrossFields.forEach { crossField in
            let operation = BlockOperation {
                DispatchQueue.main.async {
                    crossField.validateClosure()
                }
            }
            completionOperation.addDependency(operation)
            validationQueue.addOperation(operation)
        }

        OperationQueue.main.addOperation(completionOperation)
    }

    // NOTE: - Override these methods to implement the validation strategy
    // NOTE2: - Overridable methods cannot be placed in extension

    public func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper] {
        return []
    }

    public func notifyValidationDelegate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool) {
        let success = !validatableFields.contains(where: { $0.fieldValidationState == .invalid || $0.fieldValidationState == .neverValidated })
        let statusArray = validatableFields.map({
            (id: $0.fieldValidation.fieldId, editState: $0.fieldEditState, validationState: $0.fieldValidationState)
        })
        if allValidatedManually {
            delegate?.manualFormValidationDidEnd(success: success, statusArray: statusArray)
        } else {
            delegate?.autoFormValidationDidEnd(success: success, statusArray: statusArray)
        }
    }

    public func validatableCrossFieldsBy(validatableFields: [FieldValidationWrapper]) -> [CrossFieldValidationRule] {
        let validatableFieldIds = Set(validatableFields.map({ $0.fieldValidation.fieldId }))

        return crossFields.filter { crossField -> Bool in
            return Set(crossField.relatedFieldIds).intersection(validatableFieldIds).count > 0
        }
    }

    public func resetValidationStateFor(id: Int) {
        guard let validatableField = fields.first(where: { $0.fieldValidation.fieldId == id }) else {
            assertionFailure("There is no registered field with \(id) id!")
            return
        }

        validatableField.fieldEditState = .neverEdited
        validatableField.fieldValidationState = .neverValidated
    }

    public func setEnableFieldValidationBy(id: Int, enable: Bool) {
        guard let validatableField = fields.first(where: { $0.fieldValidation.fieldId == id }) else {
            assertionFailure("There is no registered field with \(id) id!")
            return
        }

        validatableField.fieldValidation.isEnabled = enable
    }

    public func setEnableFieldValidationForAll(_ enable: Bool) {
        fields.forEach({ $0.fieldValidation.isEnabled = enable })
    }

    public func fieldState(id: Int) -> FieldState? {
        guard let validatableField = fields.first(where: { $0.fieldValidation.fieldId == id }) else {
            assertionFailure("There is no registered field with \(id) id!")
            return nil
        }

        return FieldState(fieldEditState: validatableField.fieldEditState, fieldValidationState: validatableField.fieldValidationState)
    }

    // MARK: - Functions

    private func registerField(_ field: FieldValidationProtocol, at index: Int) {
        var field = field
        field.delegate = self
        field.dataSource = self
        let wrapper = FieldValidationWrapper(fieldValidation: field)
        guard !fields.contains(where: { $0.fieldValidation.fieldId == field.fieldId }) else {
            assertionFailure("\(field.fieldId) is already registered")
            return
        }
        fields.insert(wrapper, at: index)
    }
}

// MARK: - FieldRuleDelegate

extension BaseFormValidator: FieldValidationDelegate {
    public func validationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult]) {
        guard let field = fields.first(where: { $0.fieldValidation.fieldId == fieldId }) else {
            assertionFailure("Unregistered field with id: \(fieldId)")
            return
        }

        field.fieldValidationState = FieldValidationState.stateByValidity(success)
        delegate?.fieldValidationDidEnd(fieldId: fieldId, success: success, validationRuleResults: validationRuleResults)
    }
}

// MARK: - FieldValidationDataSource

extension BaseFormValidator: FieldValidationDataSource {
    public func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        guard let dataSource = dataSource else {
            throw ValigatorError.noDataSource
        }

        return try dataSource.validatableValue(for: fieldId)
    }
}
