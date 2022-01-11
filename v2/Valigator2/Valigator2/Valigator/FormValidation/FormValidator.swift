//
//  FormValidator.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import Combine

public protocol FieldHandler {
    func fieldChanged(_ field: FieldWrapper)
}

/// This protocol contains the public properties and methods of the Form Validation to implement the validation strategy.
public protocol FormValidator: FieldHandler {
    var fields: [Weak<FieldWrapper>] { get set }
    var validationPublisher: AnyPublisher<FormValidationResult, Error> { get }
}
