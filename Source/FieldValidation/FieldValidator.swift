//
//  FieldValidator.swift
//  Valigator
//

import Foundation

/// This class contains the logic to validate a single field.
public final class FieldValidator<InputType, Rule: ValidationRuleProtocol> where Rule.InputType == InputType {
    // MARK: - Properties

    private let rules: [Rule]

    // MARK: - FieldValidationProtocol properties

    /// The object that acts as the delegate of FieldValidation
    public weak var delegate: FieldValidationDelegate?

    /// The object that acts as the data source of FieldValidation
    public weak var dataSource: FieldValidationDataSource?

    /// Field identifier
    public let fieldId: Int

    /// A Boolean value indicating that the validation process is enabled for the given field
    public var isEnabled: Bool

    // MARK: - Initialization

    /// Constructor
    /// - Parameter model: Field validation model
    public init(model: FieldValidationModel<InputType, Rule>) {
        self.fieldId = model.fieldId
        self.rules = model.rules
        self.isEnabled = model.isEnabled
    }
}

// MARK: - FieldValidationProtocol

extension FieldValidator: FieldValidationProtocol {
    /// Validates the given field
    public func validateField() {
        guard let dataSource = dataSource else {
            assertionFailure("dataSource cannot be nil")
            delegate?.validationDidEnd(fieldId: fieldId, success: false, validationRuleResults: [])
            return
        }

        let value: InputType
        do {
            value = try dataSource.validatableValue(for: fieldId)
        } catch {
            assertionFailure("Invalid InputType! If the value can be nil, you should use a Rule with optional InputType!")
            delegate?.validationDidEnd(fieldId: fieldId, success: false, validationRuleResults: [])
            return
        }

        var isSuccess = true
        var validationRuleResults = [ValidationRuleResult]()

        for rule in rules {
            let isRuleSucceded = rule.validate(value: value)
            if !isRuleSucceded {
                isSuccess = false
            }
            let ruleResult = ValidationRuleResult(tag: rule.tag, passed: isRuleSucceded, message: rule.message)
            validationRuleResults.append(ruleResult)
        }
        delegate?.validationDidEnd(fieldId: fieldId, success: isSuccess, validationRuleResults: validationRuleResults)
    }
}
