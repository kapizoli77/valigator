//
//  LowercaseLetter.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public class LowercaseLetter: Regex {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = ".*(?=(?:[^a-z]*[a-z]){1}).*"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
