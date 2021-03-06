//
//  ValidationRuleProtocol.swift
//  Valigator
//

import Foundation

/**
 This protocol contains the public properties and functions for a specific validation rule for a single field.
 */
public protocol ValidationRuleProtocol {
    // MARK: - Types

    associatedtype InputType

    // MARK: - Properties

    var message: String { get }
    var tag: Int? { get }

    // MARK: - Functions

    func validate(value: InputType) -> Bool
}
