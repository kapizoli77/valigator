//
//  BaseFormValidator.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

import Combine
import Foundation

class BaseFormValidator {
    var cancellables = Set<AnyCancellable>()
    var validatableFields = CurrentValueSubject<[FieldWrapper], Never>([])
    var validationSubject = CurrentValueSubject<FormValidationResult, Error>(.failed([]))
    private let validationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    // TODO: - Change Array to OrderedSet
    public var fields = [Weak<FieldWrapper>]()
    public var validationPublisher: AnyPublisher<FormValidationResult, Error> {
        validationSubject.eraseToAnyPublisher()
    }

    init() {
        setupBindings()
    }

    open func setupBindings() {
        validatableFields
            .subscribe(on: validationQueue)
            .flatMap { validatableFields -> AnyPublisher<([FieldWrapper], [FieldValidationResult]), Never> in
                Publishers.MergeMany(validatableFields.map { $0.validate(validatableFields: validatableFields) })
                    .collect()
                    .map { (validatableFields, $0) }
                    .eraseToAnyPublisher()
            }
            .map { pair in
                let success = pair.0.allSatisfy { $0.validationState == .valid }
                let result: FormValidationResult = success ? .passed : .failed(pair.1)
                return result
            }
            .assign(to: \.value, on: validationSubject)
            .store(in: &cancellables)
    }

    // NOTE: - Override this methods to implement the validation strategy

    open func validatableFields(by field: FieldWrapper) -> [FieldWrapper] {
        return []
    }
}

// MARK: - FormValidator

extension BaseFormValidator: FormValidator {}

// MARK: - FieldHandler

extension BaseFormValidator {
    func fieldChanged(_ field: FieldWrapper) {
        let validatableFields = validatableFields(by: field)
        self.validatableFields.send(validatableFields)
    }
}
