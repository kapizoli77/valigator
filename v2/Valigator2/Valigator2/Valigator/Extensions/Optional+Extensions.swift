//
//  Optional+Extensions.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2021. 12. 28..
//

extension Optional where Wrapped: CustomStringConvertible {
    /// A Boolean value indicating whether an optional string has no characters.
    public var isEmpty: Bool {
        return self?.description.isEmpty ?? true
    }
}
