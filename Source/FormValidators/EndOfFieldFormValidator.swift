//
//  EndOfFieldFormValidator.swift
//  Valigator
//

import Foundation

class EndOfFieldFormValidator: BaseFormValidator {
    // MARK: - BaseFormValidator functions

    override func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper] {
        guard let lastModified = fields.first(where: { $0.fieldValidation.shouldValidate && $0.fieldValidation.fieldId == fieldId }) else {
            return []
        }

        if lastModified.fieldEditState == .didEdited {
            return [lastModified]
        } else {
            return []
        }
    }
}
