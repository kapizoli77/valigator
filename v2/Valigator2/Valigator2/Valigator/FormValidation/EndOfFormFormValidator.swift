//
//  EndOfFormFormValidator.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

class EndOfFormFormValidator: BaseFormValidator {
    override func validatableFields(by field: FieldWrapper) -> [FieldWrapper] {
        let validatableFields = fields.compactMap { ($0.object?.isEnabled ?? false) ? $0.object : nil}
        guard let index = validatableFields.firstIndex(where: { $0.id == field.id }) else {
            return []
        }

        // NOTE: If the last edited field is the last item, validate all
        if index == validatableFields.count - 1 && field.editState == .didEdited {
            return validatableFields
        } else {
            return []
        }
    }
}
