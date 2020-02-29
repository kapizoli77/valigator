//
//  ExcludeCharactersValidationRule.swift
//  Valigator
//

import Foundation

public class ExcludeCharactersValidationRule: BaseValidationRule<String?> {
    // MARK: - ValidationRuleProtocol properties

    public let excludedCharacters: [Character]

    // MARK: - Initialization

    public init(message: String, excludedCharacters: [Character]) {
        self.excludedCharacters = excludedCharacters

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = value else { return true }

        for excludedCharacter in excludedCharacters where value.contains(excludedCharacter) {
            return false
        }

        return true
    }
}
