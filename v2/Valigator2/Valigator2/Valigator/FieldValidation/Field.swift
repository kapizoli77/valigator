//
//  Field.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import Foundation

@propertyWrapper
public class Field {
    private var value: String?
    public var id: String
    public var rules: [ValidationRule]
    public var isEnabled: Bool

    public var wrappedValue: String? {
        get { value }
        set { projectedValue.setValue(newValue, userInteraction: false) }
    }

    public lazy var projectedValue: FieldWrapper = {
        FieldWrapper(id: id,
                     rules: rules,
                     isEnabled: isEnabled,
                     valueGetter: { [weak self] in self?.value },
                     valueSetter: { [weak self] newValue in self?.value = newValue })
    }()

    public init(wrappedValue: String? = nil,
                id: String = UUID().uuidString,
                rules: [ValidationRule],
                isEnabled: Bool = true) {
        self.value = wrappedValue
        self.id = id
        self.rules = rules
        self.isEnabled = isEnabled
    }
}
