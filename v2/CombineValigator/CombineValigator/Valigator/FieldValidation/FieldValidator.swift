//
//  FieldValidator.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 03..
//

import Foundation
import Combine

enum FieldValidationEvent {
    case didEnd(success: Bool, validationRuleResults: [ValidationRuleResult])
}

/// This class contains the logic to validate a single field.
public final class FieldValidator<InputType, Rule: ValidationRuleProtocol, ValidatableType: Validatable>
where Rule.InputType == InputType, ValidatableType.ValueTpe == InputType {
    // MARK: - Properties

    private let rules: [Rule]
    private let validationSubject = PassthroughSubject<FieldValidationEvent, Error>()

    // MARK: - FieldValidationProtocol properties

//    /// The object that acts as the delegate of FieldValidation
//    public weak var delegate: FieldValidationDelegate?
//
//    /// The object that acts as the data source of FieldValidation
//    public weak var dataSource: FieldValidationDataSource?

    /// Field identifier
    public let field: ValidatableType

    /// A Boolean value indicating that the validation process is enabled for the given field
    public var isEnabled: Bool

    // MARK: - Initialization

    /// Constructor
    /// - Parameter model: Field validation model
    public init(model: FieldValidationModel<InputType, Rule, ValidatableType>) {
        self.field = model.field
        self.rules = model.rules
        self.isEnabled = true //model.isEnabled
    }
}

// MARK: - FieldValidationProtocol

extension FieldValidator: FieldValidationProtocol {
    /// Validates the given field
    public func validateField() {
//        guard let dataSource = dataSource else {
//            assertionFailure("dataSource cannot be nil")
//            delegate?.validationDidEnd(fieldId: fieldId, success: false, validationRuleResults: [])
//            return
//        }
//
//        let value: InputType
//        do {
//            value = try dataSource.validatableValue(for: fieldId)
//        } catch {
//            assertionFailure("Invalid InputType! If the value can be nil, you should use a Rule with optional InputType!")
//            delegate?.validationDidEnd(fieldId: fieldId, success: false, validationRuleResults: [])
//            return
//        }
//
//        var isSuccess = true
//        var validationRuleResults = [ValidationRuleResult]()
//
//        for rule in rules {
//            let isRuleSucceded = rule.validate(value: value)
//            if !isRuleSucceded {
//                isSuccess = false
//            }
//            let ruleResult = ValidationRuleResult(tag: rule.tag, passed: isRuleSucceded, message: rule.message)
//            validationRuleResults.append(ruleResult)
//        }
//        delegate?.validationDidEnd(fieldId: fieldId, success: isSuccess, validationRuleResults: validationRuleResults)
    }
}
