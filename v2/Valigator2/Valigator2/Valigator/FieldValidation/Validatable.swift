//
//  Validatable.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

public protocol Validatable: AnyObject {
    func bindTo(_ field: FieldWrapper)
    func setValue(_ value: String?)
}
