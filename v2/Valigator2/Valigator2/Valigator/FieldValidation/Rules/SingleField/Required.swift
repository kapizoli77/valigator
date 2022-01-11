//
//  Required.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

class Required: SingleFieldRule {
    var message: String
    var tag: Int?

    init(message: String, tag: Int? = nil) {
        self.message = message
        self.tag = tag
    }

    func validate(value: String?) -> Bool {
        !value.isEmpty
    }
}
