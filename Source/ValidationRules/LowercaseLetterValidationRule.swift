//
//  LowercaseLetterValidationRule.swift
//  Valigator
//

import Foundation

public class LowercaseLetterValidationRule: RegexValidationRule {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = ".*(?=(?:[^a-z]*[a-z]){1}).*"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
