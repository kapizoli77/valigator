//
//  Regex.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

import Foundation

public class Regex: SingleFieldRule {
    public let regex: String
    public var message: String
    public var tag: Int?

    public init(regex: String, message: String, tag: Int? = nil) {
        self.regex = regex
        self.message = message
        self.tag = tag
    }

    public func validate(value: String?) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: value ?? "")
    }
}
