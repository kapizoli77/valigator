//
//  UITextView+Validatable.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import UIKit

extension UITextView: Validatable {
    public func bindTo(_ field: FieldWrapper) {
        // TODO: - Implement this (check CombineCocoa's solution to handle changes)
    }

    public func setValue(_ value: String?) {
        text = value
    }
}
