//
//  SingleFieldRule.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public protocol SingleFieldRule: ValidationRule {
    func validate(value: String?) -> Bool
}
