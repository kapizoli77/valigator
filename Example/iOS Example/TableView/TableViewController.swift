//
//  ViewController.swift
//  iOS Example
//

import UIKit
import Valigator

class TableViewController: UIViewController {
    // Properties

    // If we would like to use Valigator in a UITableView or a CollectionView validation should be triggered only when the field lose the focus,
    // or otherwise we reload the cell for every modification, and every changes will hides the keyboard
    let valigator = Valigator(validationStrategy: .endOfField)
    let fieldValueManager = FieldValueManager()
    @IBOutlet private var tableView: UITableView!
    private var viewModels = [TableViewCellViewModel]()
    private lazy var fieldChangeHandler: (Any?, Int, Bool) -> Void = { [weak self] value, fieldId, isActive in
        guard let self = self else {
            return
        }

        self.fieldValueManager.setValue(value, for: fieldId)
        self.valigator.editStateDidChanged(fieldId: fieldId, isActive: isActive)
    }

    // UIViewController functions

    override func viewDidLoad() {
        super.viewDidLoad()

        generateViewModels()
        registerValigator()
    }

    // MARK: - Functions

    private func generateViewModels() {
        for i in 0...20 {
            let viewModel = TableViewCellViewModel(
                identifier: i,
                title: "title-\(i)",
                errorState: .hide,
                textProvider: { [weak self] fieldId -> String in
                    guard let self = self else { return "" }

                    do {
                        return try self.fieldValueManager.validatableValue(for: fieldId) as String
                    } catch {
                        return ""
                    }
                }, fieldChangeHandler: fieldChangeHandler)

            viewModels.append(viewModel)
        }
    }

    private func registerValigator() {
        valigator.delegate = self
        valigator.dataSource = self

        for i in 0...viewModels.count {
            let requiredRule = RequiredStringValidationRule(message: "This field is required")
            let field = FieldValidationModel(fieldId: i, rules: [requiredRule])
            valigator.registerField(field)
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

extension TableViewController: UITableViewDelegate {}

// MARK: - ValigatorDelegate

extension TableViewController: ValigatorDelegate {
    func fieldValidationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult]) {
        // Here we can implement how to handle if more than 1 rule gives us validation error,
        // for example get the first message (validationRuleResults array contains all rule's result, valid and invalid too)
        let errorMessage = validationRuleResults.first(where: { !$0.passed })?.message

        let cellErrorState: CellErrorState
        if !success, let errorMessage = errorMessage {
            cellErrorState = .show(errorMessage)
        } else {
            cellErrorState = .hide
        }

        // Override errorState to the given cell viewModell, these are structs, so must to replace it, or create a mutating function
        guard var viewModel = viewModels[safe: fieldId] else {
            debugPrint("Invalid viewModel index \(fieldId)")
            return
        }
        viewModel.errorState = cellErrorState
        viewModels[fieldId] = viewModel

        // In this case fieldId will be equal with the indexPath.row, so just reload this row
        tableView.reloadRows(at: [IndexPath(row: fieldId, section: 0)], with: .automatic)
    }
}

// MARK: - ValigatorDataSource

extension TableViewController: ValigatorDataSource {
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        return try fieldValueManager.validatableValue(for: fieldId)
    }
}
