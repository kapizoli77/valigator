//
//  FieldValidator.swift
//  Valigator
//

import Foundation

/**
 This class contains the logic to validate a single field.
 */
public final class FieldValidator<InputType, Rule: InputRule> where Rule.InputType == InputType {
    // MARK: - Properties

    private let rules: [Rule]

    // MARK: - FieldValidationProtocol properties

    public weak var delegate: FieldValidationDelegate?
    public weak var dataSource: FieldValidationDataSource?
    public let fieldId: Int
    public var shouldValidate: Bool

    // MARK: - Initialization

    public init(model: FieldValidationModel<InputType, Rule>) {
        self.fieldId = model.fieldId
        self.rules = model.rules
        self.shouldValidate = model.shouldValidate
    }
}

// MARK: - FieldValidationProtocol

extension FieldValidator: FieldValidationProtocol {
    public func validateField() {
        guard let dataSource = dataSource else {
            assertionFailure("dataSource cannot be nil")
            delegate?.validationDidEnd(fieldId: fieldId, success: false, messages: [], inputRuleResults: [])
            return
        }

        let value: InputType
        do {
            value = try dataSource.validatableValue(for: fieldId)
        } catch {
            assertionFailure("Invalid InputType! If the value can be nil, you should use a Rule with optional InputType!")
            delegate?.validationDidEnd(fieldId: fieldId, success: false, messages: [], inputRuleResults: [])
            return
        }

        var messages = [String]()
        var inputRuleResults = [InputRuleResult]()

        for rule in rules {
            var isSuccess = true
            if !rule.validate(value: value) {
                messages.append(rule.message)
                isSuccess = false
            }

            if let tag = rule.tag {
                inputRuleResults.append((tag, isSuccess))
            }
        }
        delegate?.validationDidEnd(fieldId: fieldId, success: messages.isEmpty, messages: messages, inputRuleResults: inputRuleResults)
    }
}
