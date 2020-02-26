//
//  UppercaseLetterInputRule.swift
//  Valigator
//

import Foundation

public class UppercaseLetterInputRule: RegexInputRule {
    // MARK: - Properties

    private static let regex = ".*(?=(?:[^A-Z]*[A-Z]){1}).*"

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: UppercaseLetterInputRule.regex, message: message)
    }
}
