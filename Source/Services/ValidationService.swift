//
//  ValidationService.swift
//  Valigator
//

import Foundation

public class ValidationService {
    // MARK: - Properties

    private var formValidator: FormValidatorProtocol?

    // MARK: - ValidationServiceProtocol properties

    public let validationStrategy: ValidationStrategy
    public weak var validationServiceDelegate: ValidationServiceDelegate?
    public weak var validationServiceDataSource: ValidationServiceDataSource?
    public var isAllFieldValid: Bool {
        return formValidator?.isAllFieldValid ?? false
    }

    // MAKR: - Initialization

    public init(validationStrategy: ValidationStrategy = .duringEdit) {
        self.validationStrategy = validationStrategy
        self.formValidator = validationStrategy.createFormValidator(delegate: self, dataSource: self)
    }
}

// MARK: - ValidationServiceProtocol

extension ValidationService: ValidationServiceProtocol {
    public func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>) where InputRule.InputType == InputType {
        let field = FieldValidator(model: fieldModel)
        formValidator?.registerField(field)
    }

    public func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>,
                                                    before beforeId: Int) -> Bool where InputRule.InputType == InputType {
        let field = FieldValidator(model: fieldModel)
        return formValidator?.registerField(field, before: beforeId) ?? false
    }

    public func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>,
                                                    after afterId: Int) -> Bool where InputRule.InputType == InputType {
        let field = FieldValidator(model: fieldModel)
        return formValidator?.registerField(field, after: afterId) ?? false
    }

    public func registerCrossFieldInputRule(crossFieldInputRule: CrossFieldInputRule) {
        formValidator?.registerCrossFieldInputRule(crossFieldInputRule: crossFieldInputRule)
    }

    public func validateFieldBy(id: Int) {
        formValidator?.validateFieldBy(id: id)
    }

    public func validateFieldBy(index: Int) {
        formValidator?.validateFieldBy(index: index)
    }

    public func validateAllField() {
        formValidator?.validateAllField()
    }

    public func editStateDidChanged(fieldId: Int, isActive: Bool) {
        let state: FieldEditState = isActive ? .editing : .didEdited
        formValidator?.fieldEditStateDidChangeFor(fieldId: fieldId, state: state)
    }

    public func resetValidationStateFor(fieldId: Int) {
        formValidator?.resetValidationStateFor(id: fieldId)
    }

    public func setEnableFieldValidationBy(id: Int, enable: Bool) {
        formValidator?.setEnableFieldValidationBy(id: id, enable: enable)
    }

    public func fieldState(id: Int) -> FieldState? {
        return formValidator?.fieldState(id: id)
    }
}

// MARK: - FormValidatorDelegate

extension ValidationService: FormValidatorDelegate {
    public func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {
        validationServiceDelegate?.autoFormValidationDidEnd(success: success, statusArray: statusArray)
    }

    public func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {
        validationServiceDelegate?.manualFormValidationDidEnd(success: success, statusArray: statusArray)
    }

    public func fieldValidationDidEnd(fieldId: Int, success: Bool, messages: [String], inputRuleResults: [InputRuleResult]) {
        validationServiceDelegate?.fieldValidationDidEnd(fieldId: fieldId, success: success, messages: messages, inputRuleResults: inputRuleResults)
    }
}

// MARK: - FormValidatorDataSource

extension ValidationService: FormValidatorDataSource {
    public func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        guard let validationServiceDataSource = validationServiceDataSource else {
            throw ValidationServiceError.noDataSource
        }

        return try validationServiceDataSource.validatableValue(for: fieldId)
    }
}
