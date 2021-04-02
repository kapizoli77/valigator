//
//  OnlyLetterOrNumberValidationRule.swift
//  Valigator
//

import Foundation

public final class OnlyLetterOrNumberValidationRule: RegexValidationRule {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = "[a-zA-Z0-9]+"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }

    // MARK: - RegexValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return super.validate(value: value)
    }
}
