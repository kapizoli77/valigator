//
//  Valigator.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 03..
//

import Foundation

public class Valigator {
    // MARK: - Properties
    
    private var formValidator: FormValidatorProtocol?

    // MARK: - ValigatorProtocol properties

    public let validationStrategy: ValidationStrategy
    //    public weak var delegate: ValigatorDelegate?
    //    public weak var dataSource: ValigatorDataSource?
    //    public var isAllFieldValid: Bool {
    //        return formValidator?.isAllFieldValid ?? false
    //    }
    
    // MAKR: - Initialization
    
    public init(validationStrategy: ValidationStrategy = .duringEdit) {
        self.validationStrategy = validationStrategy
        self.formValidator = validationStrategy.createFormValidator()
    }
}

// MARK: - ValigatorProtocol

extension Valigator/*: ValigatorProtocol*/ {
    public func registerField<InputType, ValidationRule, ValidatableType>(_ fieldModel: FieldValidationModel<InputType, ValidationRule, ValidatableType>)
    where ValidationRule.InputType == InputType {
        let field = FieldValidator(model: fieldModel)
        formValidator?.registerField(field)
    }
    
    //    public func registerField<InputType, ValidationRule>(_ fieldModel: FieldValidationModel<InputType, ValidationRule>,
    //                                                         before beforeId: Int) -> Bool where ValidationRule.InputType == InputType {
    //        let field = FieldValidator(model: fieldModel)
    //        return formValidator?.registerField(field, before: beforeId) ?? false
    //    }
    //
    //    public func registerField<InputType, ValidationRule>(_ fieldModel: FieldValidationModel<InputType, ValidationRule>,
    //                                                         after afterId: Int) -> Bool where ValidationRule.InputType == InputType {
    //        let field = FieldValidator(model: fieldModel)
    //        return formValidator?.registerField(field, after: afterId) ?? false
    //    }
    //
    //    public func registerCrossFieldValidationRule(crossFieldValidationRule: CrossFieldValidationRule) {
    //        formValidator?.registerCrossFieldValidationRule(crossFieldValidationRule: crossFieldValidationRule)
    //    }
    //
    //    public func validateFieldBy(id: Int) {
    //        formValidator?.validateFieldBy(id: id)
    //    }
    //
    //    public func validateFieldBy(index: Int) {
    //        formValidator?.validateFieldBy(index: index)
    //    }
    //
    //    public func validateAllField() {
    //        formValidator?.validateAllField()
    //    }
    //
    //    public func editStateDidChanged(fieldId: Int, isActive: Bool) {
    //        let state: FieldEditState = isActive ? .editing : .didEdited
    //        formValidator?.fieldEditStateDidChangeFor(fieldId: fieldId, state: state)
    //    }
    //
    //    public func resetValidationStateFor(fieldId: Int) {
    //        formValidator?.resetValidationStateFor(id: fieldId)
    //    }
    //
    //    public func setEnableFieldValidationBy(id: Int, enable: Bool) {
    //        formValidator?.setEnableFieldValidationBy(id: id, enable: enable)
    //    }
    //
    //    public func fieldState(id: Int) -> FieldState? {
    //        return formValidator?.fieldState(id: id)
    //    }
}

// MARK: - FormValidatorDelegate

//extension Valigator: FormValidatorDelegate {
//    public func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {
//        delegate?.autoFormValidationDidEnd(success: success, statusArray: statusArray)
//    }
//
//    public func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {
//        delegate?.manualFormValidationDidEnd(success: success, statusArray: statusArray)
//    }
//
//    public func fieldValidationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult]) {
//        delegate?.fieldValidationDidEnd(fieldId: fieldId, success: success, validationRuleResults: validationRuleResults)
//    }
//}

// MARK: - FormValidatorDataSource

//extension Valigator: FormValidatorDataSource {
//    public func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
//        guard let dataSource = dataSource else {
//            throw ValigatorError.noDataSource
//        }
//
//        return try dataSource.validatableValue(for: fieldId)
//    }
//}
