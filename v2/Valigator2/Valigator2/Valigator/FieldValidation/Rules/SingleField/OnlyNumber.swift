//
//  OnlyNumber.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public final class OnlyNumber: Regex {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = "[0-9]+"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
