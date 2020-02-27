//
//  ViewController.swift
//  iOS Example
//
//  Created by Kapi Zoltán on 2020. 02. 27..
//  Copyright © 2020. kapizoli77. All rights reserved.
//

import UIKit
import Valigator

class TableViewController: UIViewController {
    // Properties

    let validationService = ValidationService(validationStrategy: .duringEdit)
    let fieldValueManager = FieldValueManager()
    @IBOutlet private var tableView: UITableView!
    private var viewModels = [TableViewCellViewModel]()
    private lazy var fieldChangeHandler: (Any?, Int, Bool) -> Void = { [weak self] value, fieldId, isActive in
        guard let self = self else {
            return
        }

        self.fieldValueManager.setValue(value, for: fieldId)
        self.validationService.editStateDidChanged(fieldId: fieldId, isActive: isActive)
    }
    

    // UIViewController functions

    override func viewDidLoad() {
        super.viewDidLoad()

        generateViewModels()
        registerValidationService()
    }

    // MARK: - Functions

    private func generateViewModels() {
        for i in 0...20 {
            let viewModel = TableViewCellViewModel(identifier: i,
                                                   title: "title-\(i)",
                textProvider: { [weak self] fieldId -> String in
                    guard let self = self else {
                        return ""
                    }

                    do {
                        return try self.fieldValueManager.validatableValue(for: fieldId) as String
                    } catch {
                        return ""
                    }
                }, fieldChangeHandler: fieldChangeHandler)

            viewModels.append(viewModel)
        }
    }

    private func registerValidationService() {
        validationService.validationServiceDelegate = self
        validationService.validationServiceDataSource = self

        for i in 0...viewModels.count {
            let rules = [RequiredStringInputRule(message: "This field is required")]
            let field = FieldValidationModel(fieldId: i, rules: rules)
            validationService.registerField(field)
        }
    }
}

// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "InputFieldTableViewCell") as? InputFieldTableViewCell
        if cell == nil {
            cell = InputFieldTableViewCell(style: .default, reuseIdentifier: "InputFieldTableViewCell")
        }

        if let viewModel = viewModels[safe: indexPath.row] {
            cell?.setup(with: viewModel)
        } else {
            debugPrint("Invalid viewmodel index")
        }

        return cell!
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {

}

// MARK: - ValidationServiceDelegate

extension TableViewController: ValidationServiceDelegate {

}

// MARK: - ValidationServiceDataSource

extension TableViewController: ValidationServiceDataSource {
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        return try fieldValueManager.validatableValue(for: fieldId)
    }
}
