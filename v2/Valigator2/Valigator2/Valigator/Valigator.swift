//
//  Valigator.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 28..
//

import Combine

extension Valigator {
    public enum Behavior {

        /// Never validate
        case turnedOff

        /// Validate only on user interaction
        case validateOnUserInteraction

        /// Validate both on user interaction and programmatically value change
        case validateAlways
    }
}

public class Valigator {
    private var formValidator: FormValidator

    public var behavior = Behavior.validateOnUserInteraction

    var validationPublisher: AnyPublisher<FormValidationResult, Error> {
        formValidator.validationPublisher
    }

    public init(strategy: ValidationStrategy = .endOfField) {
        formValidator = strategy.createFormValidator()
    }

    // MARK: Register

    public func register(@ValigatorBuilder valigatorBuilder: () -> FieldWrapperAccumulation) {
        let newFields = valigatorBuilder().asMultipleFieldWrapper
            .map { field -> Weak<FieldWrapper> in
                field.valigator = self
                return Weak<FieldWrapper>(field)
            }
        formValidator.fields.append(contentsOf: newFields)
    }

    public func register(field: FieldWrapper, before: FieldWrapper) {
        register(field: field, before: before.id)
    }

    public func register(field: FieldWrapper, before: String) {
        guard let neighborIndex = formValidator.fields.firstIndex(where: { $0.object?.id == before }) else {
            assertionFailure("Neighbor field doesn't registered with id: \(before)!")
            return
        }

        register(field: field, index: neighborIndex)
    }

    public func register(field: FieldWrapper, after: FieldWrapper) {
        register(field: field, after: after.id)
    }

    public func register(field: FieldWrapper, after: String) {
        guard let neighborIndex = formValidator.fields.firstIndex(where: { $0.object?.id == after }) else {
            assertionFailure("Neighbor field doesn't registered with id: \(after)!")
            return
        }

        register(field: field, index: neighborIndex + 1)
    }

    public func register(field: FieldWrapper, index: Int) {
        guard index >= 0 && index <= formValidator.fields.count else {
            assertionFailure("Invalid index!")
            return
        }
        field.valigator = self
        let newField = Weak<FieldWrapper>(field)
        formValidator.fields.insert(newField, at: index)
    }

    // MARK: Remove

    public func remove(at index: Int) {
        guard index > 0 && index < formValidator.fields.count else { return }
        formValidator.fields.remove(at: index)
    }

    public func remove(with id: String) {
        if let index = formValidator.fields.firstIndex(where: {$0.object?.id == id}) {
            formValidator.fields.remove(at: index)
        }
    }

    public func remove(field: FieldWrapper) {
        if let index = formValidator.fields.firstIndex(where: {$0.object?.id == field.id}) {
            formValidator.fields.remove(at: index)
        }
    }

    // MARK: Reset

    public func resetAll() {
        formValidator.fields.forEach { $0.object?.reset() }
    }

    public func reset(id: String) {
        formValidator.fields.first { $0.object?.id == id }?.object?.reset()
    }

    public func reset(index: Int) {
        guard index >= 0 && formValidator.fields.count < index else { return }
        formValidator.fields[index].object?.reset()
    }

    // MARK: Value and edit state change

    func editStateChanged(_ field: FieldWrapper) {
        guard behavior != .turnedOff else { return }
        formValidator.fieldChanged(field)
    }

    func valueChanged(_ field: FieldWrapper, userInteraction: Bool) {
        if behavior == .turnedOff ||
            (!userInteraction && behavior == .validateOnUserInteraction) {
            return
        }
        formValidator.fieldChanged(field)
    }
}
