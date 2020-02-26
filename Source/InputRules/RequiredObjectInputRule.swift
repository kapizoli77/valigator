//
//  RequiredObjectInputRule.swift
//  Valigator
//

import Foundation

public class RequiredObjectInputRule: BaseInputRule<Any?> {
    // MARK: - BaseInputRule functions

    public override func validate(value: Any?) -> Bool {
        return value != nil
    }
}
