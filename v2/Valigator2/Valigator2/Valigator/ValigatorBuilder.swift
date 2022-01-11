//
//  ValigatorBuilder.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 29..
//

public protocol FieldWrapperAccumulation {
    var asMultipleFieldWrapper: [FieldWrapper] { get }
}

extension FieldWrapper: FieldWrapperAccumulation {
    public var asMultipleFieldWrapper: [FieldWrapper] { [self] }
}
extension Array: FieldWrapperAccumulation where Element == FieldWrapper {
    public var asMultipleFieldWrapper: [FieldWrapper] { self }
}


@resultBuilder
public struct ValigatorBuilder {
    public static func buildBlock(_ components: FieldWrapperAccumulation ...) -> FieldWrapperAccumulation {
        return components.flatMap { $0.asMultipleFieldWrapper }
    }

    public static func buildOptional(_ component: FieldWrapperAccumulation?) -> FieldWrapperAccumulation {
        return component ?? [FieldWrapper]()
    }

    public static func buildEither(first: FieldWrapperAccumulation) -> FieldWrapperAccumulation {
        return first
    }

    public static func buildEither(second: FieldWrapperAccumulation) -> FieldWrapperAccumulation {
        return second
    }
}
