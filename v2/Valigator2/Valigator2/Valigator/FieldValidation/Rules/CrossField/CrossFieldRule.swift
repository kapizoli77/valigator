//
//  CrossFieldRule.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public protocol CrossFieldRule: ValidationRule {
    var connectedIds: [String] { get }
    func validate(values: [String?]) -> Bool
}
