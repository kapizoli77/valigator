//
//  FieldValidationEntity.swift
//  Valigator
//

import Foundation

public typealias InputRuleResult = (tag: Int, passed: Bool)
public typealias FieldState = (fieldEditState: FieldEditState, fieldValidationState: FieldValidationState)

public struct FieldValidationModel<InputType, Rule: InputRule> where Rule.InputType == InputType {
    // MARK: - Properties

    public let fieldId: Int
    public let rules: [Rule]
    public let shouldValidate: Bool

    // MARK: - Initialization

    public init(fieldId: Int, rules: [Rule], shouldValidate: Bool = true) {
        self.fieldId = fieldId
        self.rules = rules
        self.shouldValidate = shouldValidate
    }
}

// MARK: - Types

public enum FieldEditState {
    case neverEdited
    case editing
    case didEdited
}

public enum FieldValidationState {
    case neverValidated
    case invalid
    case valid

    public static func stateByValidity(_ isValid: Bool) -> FieldValidationState {
        return isValid ? .valid : .invalid
    }
}
