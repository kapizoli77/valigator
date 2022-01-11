//
//  FieldValidationEntities.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 03..
//

import Foundation
import Combine

/// Generic object to model a field validation
public struct FieldValidationModel<InputType, Rule: ValidationRuleProtocol, ValidatableType: Validatable>
where Rule.InputType == InputType, ValidatableType.ValueTpe == InputType {
    // MARK: - Properties

    /// Field
    public let field: ValidatableType

    /// Registered validation rules
    public let rules: [Rule]

    /// A publisher with Boolean value indicating that field is enabled for validation
    public let enabled: AnyPublisher<Bool, Never>

    // MARK: - Initialization

    public init(field: ValidatableType,
                rules: [Rule],
                enabled: AnyPublisher<Bool, Never> = CurrentValueSubject<Bool, Never>(true).eraseToAnyPublisher()) {
        self.field = field
        self.rules = rules
        self.enabled = enabled
    }
}

/// State to indicate a field's edit state
public enum FieldEditState {
    /// The given field is never edited
    case neverEdited

    /// The given field is editing right now
    case editing

    /// The given field is edited, but not editing right now
    case didEdited
}

/// State to indicate a field's validation state
public enum FieldValidationState {
    /// The given field is never validated
    case neverValidated

    /// The given field is validated and invalid
    case invalid

    /// The given field is validated and valid
    case valid

    /// Turns the given boolean parameter to the right validation state enum case
    public static func stateByValidity(_ isValid: Bool) -> FieldValidationState {
        return isValid ? .valid : .invalid
    }
}

/// Model to store a validation rule's result
public struct ValidationRuleResult {
    // MARK: - Properties

    /// The given ValidationRule's TAG
    public let tag: Int?

    /// A Boolean value indicating that the validation process was success or not for the given ValidationRule
    public let passed: Bool

    /// The given ValidationRule's  error message
    public let message: String
}

/// A tuple to store edit and validation state for a field
public typealias FieldState = (fieldEditState: FieldEditState, fieldValidationState: FieldValidationState)
