//
//  Weak.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

public struct Weak<Object: AnyObject> {
    public weak var object: Object?

    private let provider: () -> Object?

    public init(_ object: Object) {
        let reference = object as AnyObject

        provider = { [weak reference] in
            reference as? Object
        }
    }
}
