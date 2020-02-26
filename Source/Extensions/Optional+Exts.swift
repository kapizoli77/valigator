//
//  Optional+Exts.swift
//  Valigator
//

import Foundation

extension Optional where Wrapped: CustomStringConvertible {
    var isBlank: Bool {
        return self?.description.isBlank ?? true
    }
}
