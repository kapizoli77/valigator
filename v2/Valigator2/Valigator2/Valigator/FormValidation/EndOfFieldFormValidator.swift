//
//  EndOfFieldFormValidator.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

class EndOfFieldFormValidator: BaseFormValidator {
    override func validatableFields(by field: FieldWrapper) -> [FieldWrapper] {
        guard field.isEnabled else {
            return []
        }

        return field.editState == .didEdited ? [field] : []
    }
}
