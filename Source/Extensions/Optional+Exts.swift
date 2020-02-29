//
//  Optional+Exts.swift
//  Valigator
//

import Foundation

extension Optional where Wrapped: CustomStringConvertible {
    /// A Boolean value indicating whether an optional string has no characters.
    var isEmpty: Bool {
        return self?.description.isEmpty ?? true
    }
}
