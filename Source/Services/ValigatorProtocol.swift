//
//  ValigatorProtocol.swift
//  Valigator
//

import Foundation

/// ValigatorProtocol is a protocol which declares the public interfaces on the Valigator.
/// This service can use to validate single fields or a list of input fields.
public protocol ValigatorProtocol {
    /// Declares the validation strategy.
    /// This is a read only property, most cases the value is set in the initializer.
    var validationStrategy: ValidationStrategy { get }

    /// The receiver’s delegate.
    var delegate: ValigatorDelegate? { get set }

    /// The object that acts as the data source of the Valigator.
    var dataSource: ValigatorDataSource? { get set }

    /// Returns true if the fields has been validated and are valid.
    var isAllFieldValid: Bool { get }

    /// Register a validatable field. The order of registration will give the order of the input fields.
    /// - Parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
    func registerField<InputType, ValidationRule>(_ fieldModel: FieldValidationModel<InputType, ValidationRule>) where ValidationRule.InputType == InputType

    /// Register a validatable field before the specific field ID.
    ///
    /// - Parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
    /// - Returns: true if the registration was successful, otherwise false
    func registerField<InputType, ValidationRule>(_ fieldModel: FieldValidationModel<InputType, ValidationRule>,
                                                  before beforeId: Int) -> Bool where ValidationRule.InputType == InputType
    /// Register a validatable field after the specific field ID.
    /// - Parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
    /// - Returns: true if the registration was successful, otherwise false
    func registerField<InputType, ValidationRule>(_ fieldModel: FieldValidationModel<InputType, ValidationRule>,
                                                  after afterId: Int) -> Bool where ValidationRule.InputType == InputType

    /// Register a validatable crossfield.
    /// - Parameter crossFieldValidationRule: a struct what declares the validation logic.
    func registerCrossFieldValidationRule(crossFieldValidationRule: CrossFieldValidationRule)

    /// Validate a field by the given identifier.
    /// - Parameter id: identifier of the validatable field.
    func validateFieldBy(id: Int)

    /// Validate a field by the given index.
    /// - Parameter index: index of the validatable field.
    func validateFieldBy(index: Int)

    /// Validate all registered field.
    func validateAllField()

    /**
     We have to call this function when the value of a field has been changed.

     * parameter fieldId: identifier of the modified field.
     * parameter isActive: a boolean what is refers to the active state of the field,
     * eg.: this should be *true* when we are editing a textfield and *false* when we have finished.
     */
    func editStateDidChanged(fieldId: Int, isActive: Bool)

    /**
     Reset validation state of a field by the given identifier.

     * parameter id: identifier of the validatable field.
     */
    func resetValidationStateFor(fieldId: Int)

    /**
     Enable/disable a field by the given identifier.

     * parameter id: identifier of the validatable field.
     * parameter enable: a boolean what refers to the 'shouldValidate' state of the field,
     * eg.: this should be *true* when we would like to validate the field and *false* when not
     */
    func setEnableFieldValidationBy(id: Int, enable: Bool)

    /**
     Get current field state.

     * parameter id: identifier of the field.
     * returns: FieldState
     */
    func fieldState(id: Int) -> FieldState?
}

/**
 Protocol that declares the methods for validation service delegate
 */
public protocol ValigatorDelegate: class {
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

extension ValigatorDelegate {
    public func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {}
    public func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {}
    public func fieldValidationDidEnd(fieldId: Int, success: Bool, messages: [String], validationRuleResults: [ValidationRuleResult]) {}
}

/// Protocol that declares the methods for validation service data source
public protocol ValigatorDataSource: class {
    /**
     Called in the validation process to get the value from input field.

     * parameter fieldId: identifier of the field

     * returns: value of the input field

     * throws: could be a ValidationServiceError or something else
     */

    /// Called in the validation process to get the value from input field.
    /// - Parameter fieldId: <#fieldId description#>
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}
