//
//  ViewModel.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 28..
//

import Foundation
import Combine

class ViewModel {
    @Field(rules: [Required(message: "Required!")])
    var field1: String? = "asd"

    @Field(rules: [Required(message: "This is required!")])
    var field2: String?

    @Field(rules: [Required(message: "This is required!")])
    var field3: String?

    @Published var isFormValid = false

    let valigator = Valigator()

    init() {
        registerValidation()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.field1 = "asdfasdfasdf"
//            self.field2 = "asd asd asd asd"
//        }
    }

    var cancellables = Set<AnyCancellable>()
    func registerValidation() {
        valigator.register {
            $field1
            $field2
            $field3
        }

        $field1.$validationState
            .sink(receiveCompletion: { _ in },
                  receiveValue: { state in
                print("field1 validationState \(state)")
            })
            .store(in: &cancellables)

        $field2.$validationState
            .sink(receiveCompletion: { _ in },
                  receiveValue: { state in
                print("field2 validationState \(state)")
            })
            .store(in: &cancellables)

        valigator.validationPublisher
            .map { $0 == .passed }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] isFormValid in
                self?.isFormValid = isFormValid
            })
            .store(in: &cancellables)
    }
}
