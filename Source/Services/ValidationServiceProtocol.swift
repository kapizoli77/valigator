//
//  ValidationServiceProtocol.swift
//  Valigator
//

import Foundation

/**
 ValidationServiceProtocol is a protocol which declares the public interfaces on the Validation servie.
 You can use this service to validate single fields or a list of input fields.
 */
public protocol ValidationServiceProtocol {
    /**
     Declares the validation strategy.
     This is a read only property, most cases the value is set in the initializer.
     */
    var validationStrategy: ValidationStrategy { get }

    /**
     The receiver’s delegate.
     */
    var validationServiceDelegate: ValidationServiceDelegate? { get set }

    /**
     The object that acts as the data source of the validation service.
     */
    var validationServiceDataSource: ValidationServiceDataSource? { get set }

    /**
     Returns true if the fields has been validated and are valid.
     */
    var isAllFieldValid: Bool { get }

    /**
     Register a validatable field. The order of registration will give the order of the input fields.

     * parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
     */
    func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>) where InputRule.InputType == InputType

    /**
     Register a validatable field before the specific field ID.

     * parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
     * returns: true if the registration was successful, otherwise false
     */
    func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>,
                                             before beforeId: Int) -> Bool where InputRule.InputType == InputType
    /**
     Register a validatable field after the specific field ID.

     * parameter fieldModel: model that describe field with generic type to define the type of the validatable value.
     * returns: true if the registration was successful, otherwise false
     */
    func registerField<InputType, InputRule>(_ fieldModel: FieldValidationModel<InputType, InputRule>,
                                             after afterId: Int) -> Bool where InputRule.InputType == InputType

    /**
     Register a validatable crossfield.

     * parameter crossFieldInputRule: a struct what declares the validation logic.
     */
    func registerCrossFieldInputRule(crossFieldInputRule: CrossFieldInputRule)

    /**
     Validate a field by the given identifier.

     * parameter id: identifier of the validatable field.
     */
    func validateFieldBy(id: Int)

    /**
     Validate a field by the given index.

     * parameter index: index of the validatable field.
     */
    func validateFieldBy(index: Int)

    /**
     Validate all registered field.
     */
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
public protocol ValidationServiceDelegate: class {
    /**
     Called when a validation process finished for all validatable field after automatic validation. The logic described in validation strategy.

     * parameter success: represents the success of the validation.
     * parameter statusArray: contains the edit and validation state for every validatable field.
     */
    func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])

    /**
    Called when a validation process finished for all validatable field, when we call validateAllField method manually.

    * parameter success: represents the success of the validation.
    * parameter statusArray: contains the edit and validation state for every validatable field.
    */
    func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)])

    /**
     Called when a validation process finished for a specific field.

     * parameter fieldId: identifier of the field.
     * parameter success: represents the success of the validation.
     * parameter messages: array of the validation error messages.
     * parameter inputRuleResults: array of tuple that contains the validation result for each rule.
                            Rules are identified by tag, if tag was not defined for the rule its result will not appear in the array.
     */
    func fieldValidationDidEnd(fieldId: Int, success: Bool, messages: [String], inputRuleResults: [InputRuleResult])
}

extension ValidationServiceDelegate {
    public func autoFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {}
    public func manualFormValidationDidEnd(success: Bool, statusArray: [(id: Int, editState: FieldEditState, validationState: FieldValidationState)]) {}
    public func fieldValidationDidEnd(fieldId: Int, success: Bool, messages: [String], inputRuleResults: [InputRuleResult]) {}
}

/**
 Protocol that declares the methods for validation service data source
 */
public protocol ValidationServiceDataSource: class {
    /**
     Called in the validation process to get the value from input field.

     * parameter fieldId: identifier of the field

     * returns: value of the input field

     * throws: could be a ValidationServiceError or something else
     */
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}
