//
//  MaxLengthInputRule.swift
//  Valigator
//

import Foundation

public class MaxLengthInputRule: BaseInputRule<String?> {
    // MARK: - InputRule properties

    public let maxLength: Int

    // MARK: - Initialization

    public init(message: String, maxLength: Int) {
        self.maxLength = maxLength

        super.init(message: message)
    }

    // MARK: - BaseInputRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        return value.count <= maxLength
    }
}
