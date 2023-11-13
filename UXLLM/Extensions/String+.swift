//
//  String+.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

extension String {
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    public func localized(with arguments: [String]) -> String {
        return String(format: self.localized(), locale: nil, arguments: arguments)
    }
    
    func trimFrontAndBackWhitespaces() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = trimmed.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        let joinedWord = words.joined(separator: " ")
        return joinedWord
    }
}

