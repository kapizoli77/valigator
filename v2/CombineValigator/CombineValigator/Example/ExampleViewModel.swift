//
//  ExampleViewModel.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 04..
//

import UIKit
import Combine

enum ValidationEvent<ValueType> {
    case becomeFocus(ValueType)
    case valueChanged(ValueType)
    case lossFocus(ValueType)
}

public protocol Validatable {
    associatedtype ValueTpe

    var validationID: String? { get set }
    var validationPublisher: AnyPublisher<ValueTpe, Never>? { get }
}

import CombineCocoa

// version 1 - using UIKit types
private enum AssociatedKeys {
    static var validationID = "validationID"
}

extension UITextField: Validatable {
    public var validationID: String? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.validationID) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.validationID, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public var validationPublisher: AnyPublisher<String?, Never>? {
        textPublisher
    }
}

// version 2 - using own types by subclassing UIKit types
//class TextField: UITextField, Validatable {
//    var validationID: String?
//
//    var validationPublisher: AnyPublisher<String?, Never>? {
//        textPublisher
//    }
//}

class ExampleViewModel {
    weak var screen: ViewController?
    private var cancellables = Set<AnyCancellable>()

    func loadData() {
        registerValidation()
    }

    func registerValidation() {
        screen?.textField0.validationPublisher?.sink(receiveCompletion: { completion in
            print("completion 0: \(completion)")
        }, receiveValue: { value in
            print("value received 0: \(value)")
        }).store(in: &cancellables)

        screen?.textField1.validationPublisher?.sink(receiveCompletion: { completion in
            print("completion 1: \(completion)")
        }, receiveValue: { value in
            print("value received 1: \(value)")
        }).store(in: &cancellables)
    }
}
