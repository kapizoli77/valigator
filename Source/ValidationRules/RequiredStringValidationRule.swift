//
//  RequiredStringValidationRule.swift
//  Valigator
//

import Foundation

public class RequiredStringValidationRule: BaseValidationRule<String?> {
    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        return !value.isEmpty
    }
}
