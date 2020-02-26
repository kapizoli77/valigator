//
//  RegexInputRule.swift
//  Valigator
//

import Foundation

public class RegexInputRule: BaseInputRule<String?> {
    // MARK: - Properties

    private var regex: String

    // MARK: - Initialization

    public init(regex: String, message: String) {
        self.regex = regex

        super.init(message: message)
    }

    // MARK: - BaseInputRule functions

    public override func validate(value: String?) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: value ?? "")
    }
}
