//
//  ValigatorEntities.swift
//  Valigator
//

import Foundation

/** Valigator Error Types

 - noDataSource: Data source is nil
 */
public enum ValigatorError: Error {
    case noDataSource
}

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

    /// Validation process never triggered
    case never

    /// We can implement a custom form validator if necessary
    case custom(FormValidatorProtocol)

    // MARK: - Functions

    func createFormValidator(delegate: FormValidatorDelegate, dataSource: FormValidatorDataSource) -> FormValidatorProtocol {
        switch self {
        case .duringEdit:
            return DuringEditFormValidator(delegate: delegate, dataSource: dataSource)
        case .endOfField:
            return EndOfFieldFormValidator(delegate: delegate, dataSource: dataSource)
        case .endOfForm:
            return EndOfFormFormValidator(delegate: delegate, dataSource: dataSource)
        case .never:
            return NeverFormValidator(delegate: delegate, dataSource: dataSource)
        case .custom(var formValidator):
            formValidator.delegate = delegate
            formValidator.dataSource = dataSource
            return formValidator
        }
    }
}
