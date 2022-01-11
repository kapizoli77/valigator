//
//  CustomTextField.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

import UIKit
import Combine

public class CustomTextField: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .darkText
        return titleLabel
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .magenta
        return errorLabel
    }()

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    var errorMessage: String? {
        get { errorLabel.text }
        set { errorLabel.text = newValue }
    }

    private var fieldWrapper: FieldWrapper?
    private var cancellables = Set<AnyCancellable>()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let titleSize = titleLabel.intrinsicContentSize
        let textFieldSize = textField.intrinsicContentSize
        let errorSize = errorLabel.intrinsicContentSize
        return CGSize(width: originalSize.width,
                      height: titleSize.height + textFieldSize.height + errorSize.height)
    }

    private func setup() {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 12, height: 12))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])

        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CustomTextField: Validatable {
    public func bindTo(_ field: FieldWrapper) {
        fieldWrapper = field
        field.validatable = self
        text = field.value
        field.$validationResult
            .sink { _ in }
            receiveValue: { [weak self] state in
                switch state {
                case .none, .passed: self?.errorMessage = ""
                case .failed(_, let validationRuleResults):
                    self?.errorMessage = validationRuleResults.first?.message
                }
            }
            .store(in: &cancellables)

        textField.addTarget(self, action: #selector(CustomTextField.handleValueChange), for: .allEditingEvents)
        textField.addTarget(self, action: #selector(CustomTextField.handleEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(CustomTextField.handleEditingDidEnd), for: .editingDidEnd)
    }

    public func setValue(_ value: String?) {
        text = value
    }

    @objc private func handleValueChange() {
        print("handleValueChange text: \(text)")
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
