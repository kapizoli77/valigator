//
//  CharacterLengthRangeValidationRule.swift
//  Valigator
//

import Foundation

public class CharacterLengthRangeValidationRule: BaseValidationRule<String?> {
    // MARK: - ValidationRuleProtocol properties

    public let minLength: Int
    public let maxLength: Int

    // MARK: - Initialization

    public init(message: String, minLength: Int, maxLength: Int) {
        self.minLength = minLength
        self.maxLength = maxLength

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return false }

        return value.count >= minLength && value.count <= maxLength
    }
}
