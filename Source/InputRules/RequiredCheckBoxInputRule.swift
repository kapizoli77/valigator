//
//  CheckBoxInputRule.swift
//  Valigator
//

import Foundation

public class RequiredCheckBoxInputRule {
    // MARK: - InputRule properties

    public let message: String
    public var tag: Int?

    // MARK: - Initialization

    public init(message: String) {
        self.message = message
    }
}

// MARK: - InputRule

extension RequiredCheckBoxInputRule: InputRule {
    public func validate(value: Bool) -> Bool {
        return value
    }
}
