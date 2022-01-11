//
//  ValidationStrategy.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

/**
 Declares the most common strategies for validation
 */
public enum ValidationStrategy {
    /// Every changes triggers a validation process for the current field
    case duringEdit

    /// If a field's status changed from .editing to .didEdited than this field will be validated
    case endOfField

    /// If a field's status changed from .editing to .didEdited and none of the registered fields is in .editing state than the form will be validated
    case endOfForm

    /// We can implement a custom form validator if necessary
    case custom(FormValidator)

    // MARK: - Functions

    func createFormValidator() -> FormValidator {
        switch self {
        case .duringEdit:
            return DuringEditFormValidator()
        case .endOfField:
            return EndOfFieldFormValidator()
        case .endOfForm:
            return EndOfFormFormValidator()
        case .custom(let formValidator):
            return formValidator
        }
    }
}
