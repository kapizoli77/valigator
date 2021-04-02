//
//  UppercaseLetterValidationRule.swift
//  Valigator
//

import Foundation

public class UppercaseLetterValidationRule: RegexValidationRule {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = ".*(?=(?:[^A-Z]*[A-Z]){1}).*"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
