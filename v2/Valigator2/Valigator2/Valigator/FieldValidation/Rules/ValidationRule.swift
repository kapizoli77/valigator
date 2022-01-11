//
//  ValidationRule.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

public protocol ValidationRule: AnyObject {
    var message: String { get set }
    var tag: Int? { get set }
}
