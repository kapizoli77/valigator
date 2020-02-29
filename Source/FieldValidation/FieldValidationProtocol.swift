//
//  FieldValidationProtocol.swift
//  Valigator
//

import Foundation

public protocol FieldValidationDataSource: class {
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType
}

public protocol FieldValidationDelegate: class {
    func validationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult])
}

public protocol FieldValidationProtocol {
    var fieldId: Int { get }
    var delegate: FieldValidationDelegate? { get set }
    var dataSource: FieldValidationDataSource? { get set }
    var isEnabled: Bool { get set }

    func validateField()
}
