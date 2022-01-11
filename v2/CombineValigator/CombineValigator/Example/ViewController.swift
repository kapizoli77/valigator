//
//  ViewController.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 03..
//

import UIKit
import Combine
import CombineCocoa

class ViewController: UIViewController {
    private let viewModel = ExampleViewModel()

    @IBOutlet weak private(set) var textField0: UITextField!
    @IBOutlet weak private(set) var textField1: UITextField!
    @IBOutlet weak private(set) var switchView: UISwitch!
    @IBOutlet weak private(set) var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.screen = self
        viewModel.loadData()
    }
}
