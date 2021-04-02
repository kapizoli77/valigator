//
//  RequiredCheckBoxValidationRule.swift
//  Valigator
//

import Foundation

public class RequiredCheckBoxValidationRule {
    // MARK: - ValidationRuleProtocol properties

    public let message: String
    public var tag: Int?

    // MARK: - Initialization

    public init(message: String) {
        self.message = message
    }
}

// MARK: - ValidationRuleProtocol

extension RequiredCheckBoxValidationRule: ValidationRuleProtocol {
    public func validate(value: Bool) -> Bool {
        return value
    }
}
