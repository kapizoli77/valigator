//
//  CharacterLengthRange.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public class CharacterLengthRange: SingleFieldRule {
    // MARK: - ValidationRuleProtocol properties

    public var message: String
    public var tag: Int?
    public let minLength: Int
    public let maxLength: Int
    

    // MARK: - Initialization

    public init(message: String, tag: Int? = nil, minLength: Int, maxLength: Int) {
        self.message = message
        self.tag = tag
        self.minLength = minLength
        self.maxLength = maxLength
    }

    public func validate(value: String?) -> Bool {
        let count = value?.count ?? 0
        return count >= minLength && count <= maxLength
    }
}
