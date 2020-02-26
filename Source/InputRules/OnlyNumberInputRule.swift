//
//  OnlyNumberInputRule.swift
//  Valigator
//

import Foundation

public final class OnlyNumberInputRule: RegexInputRule {
    // MARK: - Properties

    private static let regex = "[0-9]+"

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: OnlyNumberInputRule.regex, message: message)
    }

    // MARK: - RegexInputRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return super.validate(value: value)
    }
}
