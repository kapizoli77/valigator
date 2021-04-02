//
//  FieldValueManager.swift
//  Valigator
//

public class FieldValueManager {
    // MARK: - Properties

    private var fieldValues = [Int: Any?]()

    // MARK: - Initialization

    public init() {
    }

    // MARK: - Functions

    public func setValue(_ value: Any?, for id: Int) {
        fieldValues.updateValue(value, forKey: id)
    }

    public func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        let value = fieldValues[fieldId]

        guard let returnValue = value as? InputType else {
            throw FieldValueManagerError.invalidInputType
        }

        return returnValue
    }
}
