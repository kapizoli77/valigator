//
//  MinLengthInputRule.swift
//  Valigator
//

import Foundation

public class MinLengthInputRule: BaseInputRule<String?> {
    // MARK: - InputRule properties

    public let minLength: Int

    // MARK: - Initialization

    public init(message: String, minLength: Int) {
        self.minLength = minLength

        super.init(message: message)
    }

    // MARK: - BaseInputRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return value.count >= minLength
    }
}
