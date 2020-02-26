//
//  String+Exts.swift
//  Valigator
//

import Foundation

extension String {
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
}
