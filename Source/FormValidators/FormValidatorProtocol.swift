//
//  FormValidatorProtocol.swift
//  Valigator
//

import Foundation

public protocol FormValidatorDelegate: class {
    func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])
    func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])
    func fieldValidationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult])
}

public protocol FormValidatorDataSource: class {
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}

/**
 This protocol contains the public properties and methods of the Form Validation to implement the validation strategy.
 */
public protocol FormValidatorProtocol {
    var delegate: FormValidatorDelegate? { get set }
    var dataSource: FormValidatorDataSource? { get set }
    var isAllFieldValid: Bool { get }

    func registerField(_ field: FieldValidationProtocol)
    func registerField(_ field: FieldValidationProtocol, before beforeId: Int) -> Bool
    func registerField(_ field: FieldValidationProtocol, after afterId: Int) -> Bool
    func registerCrossFieldValidationRule(crossFieldValidationRule: CrossFieldValidationRule)
    func validateFieldBy(id: Int)
    func validateFieldBy(index: Int)
    func validateAllField()
    func fieldEditStateDidChangeFor(fieldId: Int, state: FieldEditState)
    func validate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool)
    func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper]
    func notifyValidationDelegate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool)
    func validatableCrossFieldsBy(validatableFields: [FieldValidationWrapper]) -> [CrossFieldValidationRule]
    func resetValidationStateFor(id: Int)
    func setEnableFieldValidationBy(id: Int, enable: Bool)
    func setEnableFieldValidationForAll(_ enable: Bool)
    func fieldState(id: Int) -> FieldState?
}
