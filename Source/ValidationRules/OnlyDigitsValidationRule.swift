//
//  OnlyDigitsValidationRule.swift
//  Valigator
//

import Foundation

public final class OnlyDigitsValidationRule: RegexValidationRule {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = "[0-9]*"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
