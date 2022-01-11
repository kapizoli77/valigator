//
//  UITextField+Validatable.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import UIKit

private enum AssociatedKeys {
    static var fieldWrapperKey = "FieldWrapper"
}

extension UITextField: Validatable {
    private var fieldWrapper: FieldWrapper? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.fieldWrapperKey) as? FieldWrapper }
        set { objc_setAssociatedObject(self, &AssociatedKeys.fieldWrapperKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    public func bindTo(_ field: FieldWrapper) {
        fieldWrapper = field
        field.validatable = self
        text = field.value
        addTarget(self, action: #selector(UITextField.handleValueChange), for: .valueChanged)
        addTarget(self, action: #selector(UITextField.handleEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(UITextField.handleEditingDidEnd), for: .editingDidEnd)
    }

    public func setValue(_ value: String?) {
        text = value
    }

    @objc private func handleValueChange() {
        print("handleValueChange")
        fieldWrapper?.value = text
    }

    @objc private func handleEditingDidBegin() {
        print("handleEditingDidBegin")
        fieldWrapper?.editState = .editing
    }

    @objc private func handleEditingDidEnd() {
        print("handleEditingDidEnd")
        fieldWrapper?.editState = .didEdited
    }
}
