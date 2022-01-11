//
//  FieldValidationProtocol.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 03..
//

import Foundation

/// Protocol which declares the public interfaces on the FieldValidation.
/// This service can use to validate a single field.
public protocol FieldValidationProtocol {
    associatedtype ValidatableType
    /// Field identifier
    var field: ValidatableType { get }

//    /// The object that acts as the delegate of FieldValidation
//    var delegate: FieldValidationDelegate? { get set }
//
//    /// The object that acts as the data source of FieldValidation
//    var dataSource: FieldValidationDataSource? { get set }

    /// A Boolean value indicating that the validation process is enabled for the given field
    var isEnabled: Bool { get set }

    /// Validates the given field
    func validateField()
}
