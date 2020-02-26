//
//  CrossFieldInputRule.swift
//  Valigator
//

import Foundation

public struct CrossFieldInputRule {
    // MARK: - Properties

    var relatedFieldIds: [Int]
    var validateClosure: (() -> Void)

    // MARK: - Initialization

    public init(relatedFieldIds: [Int], validateClosure: @escaping (() -> Void)) {
        self.relatedFieldIds = relatedFieldIds
        self.validateClosure = validateClosure
    }
}
