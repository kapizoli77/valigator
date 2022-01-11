//
//  FormValidatorProtocol.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 06..
//

import Foundation

/// This protocol contains the public properties and methods of the Form Validation to implement the validation strategy.
public protocol FormValidatorProtocol {
    /// The object that acts as the delegate of FormValidator
//    var delegate: FormValidatorDelegate? { get set }
//    /// The object that acts as the data source of FormValidator
//    var dataSource: FormValidatorDataSource? { get set }

    /// A Boolean value indicating that all field is valid or not
    var isAllFieldValid: Bool { get }

    func registerField(_ field: FieldValidationProtocol)
    func registerField(_ field: FieldValidationProtocol, before beforeId: Int) -> Bool
    func registerField(_ field: FieldValidationProtocol, after afterId: Int) -> Bool
//    func registerCrossFieldValidationRule(crossFieldValidationRule: CrossFieldValidationRule)
    func validateFieldBy(id: Int)
    func validateFieldBy(index: Int)
    func validateAllField()
    func fieldEditStateDidChangeFor(fieldId: Int, state: FieldEditState)
    func validate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool)
    func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper]
    func notifyValidationDelegate(validatableFields: [FieldValidationWrapper], allValidatedManually: Bool)
//    func validatableCrossFieldsBy(validatableFields: [FieldValidationWrapper]) -> [CrossFieldValidationRule]
    func resetValidationStateFor(id: Int)
    func setEnableFieldValidationBy(id: Int, enable: Bool)
    func setEnableFieldValidationForAll(_ enable: Bool)
    func fieldState(id: Int) -> FieldState?
}
