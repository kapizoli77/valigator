//
//  BaseInputRule.swift
//  Valigator
//

import Foundation

/**
 This class is needed to have a common ancector class for input rules.

 InputRule protocol is not enough since it has associated type for generic implementation
 and it makes not possible to create InputRule type arrays containing different input rules
*/
open class BaseInputRule<InputType>: InputRule {
    // MARK: - InputRule properties

    open var message: String
    open var tag: Int?

    // MARK: - Initialization

    public init(message: String) {
        self.message = message
    }

    // MARK: - InputRule functions

    open func validate(value: InputType) -> Bool {
        assertionFailure("This is an abstract funtcion, please override it in the inherited class")

        return false
    }
}
