//
//  MinLengthValidationRule.swift
//  Valigator
//

import Foundation

public class MinLengthValidationRule: BaseValidationRule<String?> {
    // MARK: - ValidationRuleProtocol properties

    public let minLength: Int

    // MARK: - Initialization

    public init(message: String, minLength: Int) {
        self.minLength = minLength

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return value.count >= minLength
    }
}
