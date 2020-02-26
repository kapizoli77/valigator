//
//  DuringEditFormValidator.swift
//  Valigator
//

import Foundation

class DuringEditFormValidator: BaseFormValidator {
    // MARK: - BaseFormValidator functions

    override func validatableFieldsAfterEditStateChanged(for fieldId: Int) -> [FieldValidationWrapper] {
        guard let lastModified = fields.first(where: { $0.fieldValidation.shouldValidate && $0.fieldValidation.fieldId == fieldId }) else {
            return []
        }

        return [lastModified]
    }
}
