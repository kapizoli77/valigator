//
//  RegexValidationRule.swift
//  Valigator
//

import Foundation

public class RegexValidationRule: BaseValidationRule<String?> {
    // MARK: - Properties

    private let regex: String

    // MARK: - Initialization

    public init(regex: String, message: String) {
        self.regex = regex

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: value ?? "")
    }
}
