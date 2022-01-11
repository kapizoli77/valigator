//
//  UppercaseLetter.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public class UppercaseLetter: Regex {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = ".*(?=(?:[^A-Z]*[A-Z]){1}).*"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
