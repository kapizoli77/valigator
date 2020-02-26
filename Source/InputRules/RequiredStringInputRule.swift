//
//  RequiredStringInputRule.swift
//  Valigator
//

import Foundation

public class RequiredStringInputRule: BaseInputRule<String?> {
    // MARK: - BaseInputRule functions

    public override func validate(value: String?) -> Bool {
        return !value.isBlank
    }
}
