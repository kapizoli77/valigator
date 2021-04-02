//
//  MaxLengthValidationRule.swift
//  Valigator
//

import Foundation

public class MaxLengthValidationRule: BaseValidationRule<String?> {
    // MARK: - ValidationRuleProtocol properties

    public let maxLength: Int

    // MARK: - Initialization

    public init(message: String, maxLength: Int) {
        self.maxLength = maxLength

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return value.count <= maxLength
    }
}
