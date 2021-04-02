//
//  EndOfFormFormValidator.swift
//  Valigator
//

import Foundation

class EndOfFormFormValidator: BaseFormValidator {
    // MARK: - BaseFormValidator functions

    override func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper] {
        let validatableFields = fields.filter({ $0.fieldValidation.isEnabled })
        guard let index = validatableFields.firstIndex(where: { $0.fieldValidation.fieldId == fieldId }) else {
            return []
        }

        let lastModifiedField = validatableFields[index]

        // NOTE: If the last edited field is the last item, validate all

        if index == validatableFields.count - 1 && lastModifiedField.fieldEditState == .didEdited {
            return validatableFields
        } else {
            return []
        }
    }
}
