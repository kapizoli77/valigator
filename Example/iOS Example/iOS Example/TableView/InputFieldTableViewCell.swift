//
//  InputFieldTableViewCell.swift
//  iOS Example
//
//  Created by Kapi Zoltán on 2020. 02. 27..
//  Copyright © 2020. kapizoli77. All rights reserved.
//

import UIKit

class InputFieldTableViewCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet private var title: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var errorLabel: UILabel!
    private var viewModel: TableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                title.text = nil
                textField.text = nil
                errorLabel.isHidden = true
                return
            }

            title.text = viewModel.title
            textField.text = viewModel.textProvider(viewModel.identifier)
            if case CellErrorState.show(let errorText) = viewModel.errorState {
                errorLabel.isHidden = false
                errorLabel.text = errorText
            } else {
                errorLabel.isHidden = true
            }

        }
    }

    // MARK: - UITableViewCell functions

    override func prepareForReuse() {
        super.prepareForReuse()

        title.text = nil
        textField.text = nil
        errorLabel.isHidden = true
    }

    // MARK: - Functions

    func setup(with viewModel: TableViewCellViewModel) {
        self.viewModel = viewModel
    }

    @IBAction func textFieldDidChange(_ textField: UITextField) {
        guard let viewModel = viewModel else { return }

        viewModel.fieldChangeHandler(textField.text, viewModel.identifier, true)
    }
}

// MARK: - UITextFieldDelegate

extension InputFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let viewModel = viewModel else { return }

        viewModel.fieldChangeHandler(textField.text, viewModel.identifier, true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let viewModel = viewModel else { return }

        viewModel.fieldChangeHandler(textField.text, viewModel.identifier, false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
