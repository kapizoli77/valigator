//
//  EqualCrossCheck.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public class EqualCrossCheck: CrossFieldRule {
    public var connectedIds: [String]
    public var message: String
    public var tag: Int?

    init(connectedIds: [String], message: String, tag: Int? = nil) {
        self.connectedIds = connectedIds
        self.message = message
        self.tag = tag
    }

    public func validate(values: [String?]) -> Bool {
        values.dropFirst().allSatisfy { $0 == values.first }
    }
}
