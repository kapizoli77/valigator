//
//  FormValidatorProtocol.swift
//  Valigator
//

import Foundation

/// Methods for managing validation process for a whole form
public protocol FormValidatorDelegate: class {
    /// Called when a validation process finished for all validatable field after automatic validation. The logic described in validation strategy.
    /// - parameter success: represents the success of the validation.
    /// - parameter statusArray: contains the edit and validation state for every validatable field.
    func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])

    /// Called when a validation process finished for all validatable field, when we call validateAllField method manually.
    /// - parameter success: represents the success of the validation.
    /// - parameter statusArray: contains the edit and validation state for every validatable field.
    func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])

    /// Called when a validation process finished for a specific field.
    /// - parameter fieldId: identifier of the field.
    /// - parameter success: represents the success of the validation.
    /// - parameter messages: array of the validation error messages.
    /// - parameter validationRuleResults: array of tuple that contains the validation result for each rule.
    /// Rules are identified by tag, if tag was not defined for the rule its result will not appear in the array.
    func fieldValidationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult])
}

/// Data source of form validator
public protocol FormValidatorDataSource: class {
    /// Provides the validatable value for the given identifier
    /// - Parameter fieldId: field identifier
    /// - Returns: the input field's value
    /// - Throws: depends on the implementation, eg. could threws an error if value's type is not equal InputType
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}

/// This protocol contains the public properties and methods of the Form Validation to implement the validation strategy.
public protocol FormValidatorProtocol {
    /// The object that acts as the delegate of FormValidator
    var delegate: FormValidatorDelegate? { get set }
    /// The object that acts as the data source of FormValidator
    var dataSource: FormValidatorDataSource? { get set }

    /// A Boolean value indicating that all field is valid or not
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
