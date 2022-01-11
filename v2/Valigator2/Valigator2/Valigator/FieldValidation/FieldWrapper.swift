//
//  FieldWrapper.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import Combine

// TODO: - Find a better name
public class FieldWrapper {
    private var valueGetter: () -> String?
    private var valueSetter: (String?) -> Void

    public var id: String
    public var rules: [ValidationRule]
    public var isEnabled: Bool
    public weak var validatable: Validatable?
    internal(set) public weak var valigator: Valigator?
    @Published internal(set) public var validationState = ValidationState.virgin
    @Published internal(set) public var validationResult: FieldValidationResult?
    @Published internal(set) public var editState = EditState.virgin {
        didSet { valigator?.editStateChanged(self) }
    }

    public var value: String? {
        get { valueGetter() }
        set { setValue(newValue, userInteraction: true ) }
    }

    init(id: String,
         rules: [ValidationRule],
         isEnabled: Bool,
         valueGetter: @escaping () -> String?,
         valueSetter: @escaping (String?) -> Void) {
        self.id = id
        self.rules = rules
        self.isEnabled = isEnabled
        self.valueGetter = valueGetter
        self.valueSetter = valueSetter
    }

    func setValue(_ value: String?, userInteraction: Bool) {
        guard value != self.value else { return }

        valueSetter(value)
        valigator?.valueChanged(self, userInteraction: userInteraction)
        validatable?.setValue(value)
    }

    public func reset() {
        validationState = .virgin
        editState = .virgin
    }
}

extension FieldWrapper: FieldValidator {
    func validate(validatableFields: [FieldWrapper]) -> AnyPublisher<FieldValidationResult, Never> {
        var success = true
        var validationRuleResults = [ValidationRuleResult]()

        /// Single filed rules
        let singleRules = rules.compactMap { $0 as? SingleFieldRule }

        for rule in singleRules {
            let ruleSucceded = rule.validate(value: value)
            if !ruleSucceded {
                success = false
            }
            let ruleResult = ValidationRuleResult(tag: rule.tag, passed: ruleSucceded, message: rule.message)
            validationRuleResults.append(ruleResult)
        }

        /// Cross filed rules
        let crossFieldRules = rules.compactMap { $0 as? CrossFieldRule }

        for rule in crossFieldRules {
            var values = validatableFields.filter { rule.connectedIds.contains($0.id) }
                .map { $0.value }
            values.insert(value, at: 0)
            let ruleSucceded = rule.validate(values: values)
            if !ruleSucceded {
                success = false
            }
            let ruleResult = ValidationRuleResult(tag: rule.tag, passed: ruleSucceded, message: rule.message)
            validationRuleResults.append(ruleResult)
        }
        validationState = success ? .valid : .invalid
        let result: FieldValidationResult = success ? .passed(id) : .failed(id, validationRuleResults)
        validationResult = result
        return Just(result).eraseToAnyPublisher()
    }
}

extension FieldWrapper: Equatable {
    public static func == (lhs: FieldWrapper, rhs: FieldWrapper) -> Bool {
        lhs.id == rhs.id
    }
}

// TODO: - Move to sepated files

protocol FieldValidator {
    func validate(validatableFields: [FieldWrapper]) -> AnyPublisher<FieldValidationResult, Never>
}


/// State to indicate a field's edit state
public enum EditState {
    /// The given field is never edited
    case virgin

    /// The given field is editing right now
    case editing

    /// The given field is edited, but not editing right now
    case didEdited
}

/// State to indicate a field's validation state
public enum ValidationState {
    /// The given field is never validated
    case virgin

    /// The given field is validated and invalid
    case invalid

    /// The given field is validated and valid
    case valid

    /// Turns the given boolean parameter to the right validation state enum case
    public static func stateByValidity(_ isValid: Bool) -> ValidationState {
        return isValid ? .valid : .invalid
    }
}

public enum FieldValidationResult: Equatable {
    case passed(String)
    case failed(String, [ValidationRuleResult])

    public static func == (lhs: FieldValidationResult, rhs: FieldValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.passed, .passed):
            return true
        case (.failed(let lId, let lResults), .failed(let rId, let rResults)) where lResults == rResults && lId == rId:
            return true
        default:
            return false
        }
    }
}

public enum FormValidationResult: Equatable {
    case passed
    case failed([FieldValidationResult])

    public static func == (lhs: FormValidationResult, rhs: FormValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.passed, .passed):
            return true
        case (.failed(let lResults), .failed(let rResults)) where lResults == rResults:
            return true
        default:
            return false
        }
    }
}

/// Model to store a validation rule's result
public struct ValidationRuleResult: Equatable {
    // MARK: - Properties

    /// The given ValidationRule's TAG
    public let tag: Int?

    /// A Boolean value indicating that the validation process was success or not for the given ValidationRule
    public let passed: Bool

    /// The given ValidationRule's  error message
    public let message: String
}
