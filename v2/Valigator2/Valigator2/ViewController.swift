//
//  ViewController.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 28..
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet private var textField1: CustomTextField!
    @IBOutlet private var textField2: CustomTextField!
    @IBOutlet private var textField3: CustomTextField!
    @IBOutlet private var button: UIButton!

    let viewModel = ViewModel()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        textField1.title = "Name"
        textField2.title = "Email"
        textField3.title = "Email again"
        button.setTitle("Save", for: .normal)
        button.isEnabled = false

        textField1.bindTo(viewModel.$field1)
        textField2.bindTo(viewModel.$field2)
        viewModel.$isFormValid
            .assign(to: \.isEnabled, on: button)
            .store(in: &cancellables)
    }
}
