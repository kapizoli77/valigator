//
//  LowercaseLetterInputRule.swift
//  Valigator
//

import Foundation

public class LowercaseLetterInputRule: RegexInputRule {
    // MARK: - Properties

    private static let regex = ".*(?=(?:[^a-z]*[a-z]){1}).*"

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: LowercaseLetterInputRule.regex, message: message)
    }
}
