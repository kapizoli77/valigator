//
//  Email.swift
//  Valigator2
//
//  Created by Kapi Zoltán on 2022. 01. 02..
//

public class Email: Regex {
    // MARK: - Types

    private struct PrivateConstants {
        static let regex = "^$|[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    }

    // MARK: - Initialization

    public convenience init(message: String) {
        self.init(regex: PrivateConstants.regex, message: message)
    }
}
