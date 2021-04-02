//
//  RequiredObjectValidationRule.swift
//  Valigator
//

import Foundation

public class RequiredObjectValidationRule: BaseValidationRule<Any?> {
    // MARK: - BaseValidationRule functions

    public override func validate(value: Any?) -> Bool {
        return value != nil
    }
}
