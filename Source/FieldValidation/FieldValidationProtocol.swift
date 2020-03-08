//
//  FieldValidationProtocol.swift
//  Valigator
//

import Foundation

/// Data source of field validation
public protocol FieldValidationDataSource: class {
    /// Provides the validatable value for the given identifier
    /// - Parameter fieldId: field identifier
    /// - Returns: the input field's value
    /// - Throws: depends on the implementation, eg. could threws an error if value's type not equal InputType
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}

/// Methods for managing validation process for a single field
public protocol FieldValidationDelegate: class {
    /// Tells the delegate the field with the given identifier was validated
    /// - Parameters:
    ///   - fieldId: field identifier
    ///   - success: validation success
    ///   - validationRuleResults: validation rule result list
    func validationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult])
}

/// Protocol which declares the public interfaces on the FieldValidation.
/// This service can use to validate a single field.
public protocol FieldValidationProtocol {
    /// Field identifier
    var fieldId: Int { get }

    /// The object that acts as the delegate of FieldValidation
    var delegate: FieldValidationDelegate? { get set }

    /// The object that acts as the data source of FieldValidation
    var dataSource: FieldValidationDataSource? { get set }

    /// A Boolean value indicating that the validation process is enabled for the given field
    var isEnabled: Bool { get set }

    /// Validates the given field
    func validateField()
}
