//
//  BaseValidationRule.swift
//  Valigator
//

import Foundation

open class BaseValidationRule<InputType>: ValidationRuleProtocol {
    // MARK: - ValidationRuleProtocol properties

    open var message: String
    open var tag: Int?

    // MARK: - Initialization

    public init(message: String) {
        self.message = message
    }

    // MARK: - ValidationRuleProtocol functions

    open func validate(value: InputType) -> Bool {
        assertionFailure("This is an abstract funtcion, please override it in the inherited class")

        return false
    }
}
