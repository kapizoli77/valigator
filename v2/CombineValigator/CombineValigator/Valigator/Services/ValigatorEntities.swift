//
//  ValigatorEntities.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 06..
//

import Foundation

/**
 Declares the most common strategies for validation
 */
public enum ValidationStrategy {
    /// Every changes triggers a validation process for the current field
    case duringEdit

//    /// If a field's status changed from .editing to .didEdited than this field will be validated
//    case endOfField
//
//    /// If a field's status changed from .editing to .didEdited and none of the registered fields is in .editing state than the form will be validated
//    case endOfForm
//
//    /// Validation process never triggered
//    case never
//
//    /// We can implement a custom form validator if necessary
//    case custom(FormValidatorProtocol)

    // MARK: - Functions

    func createFormValidator() -> FormValidatorProtocol {
        switch self {
        case .duringEdit:
            return DuringEditFormValidator()
//        case .endOfField:
//            return EndOfFieldFormValidator(delegate: delegate, dataSource: dataSource)
//        case .endOfForm:
//            return EndOfFormFormValidator(delegate: delegate, dataSource: dataSource)
//        case .never:
//            return NeverFormValidator(delegate: delegate, dataSource: dataSource)
//        case .custom(var formValidator):
//            formValidator.delegate = delegate
//            formValidator.dataSource = dataSource
//            return formValidator
        }
    }
}
