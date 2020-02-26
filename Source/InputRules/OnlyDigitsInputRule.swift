//
//  OnlyDigitsInputRule.swift
//  Valigator
//

import Foundation

public final class OnlyDigitsInputRule: RegexInputRule {
    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: "[0-9]*", message: message)
    }
}
