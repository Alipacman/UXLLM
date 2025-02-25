//
//  String+.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

// MARK: - General
extension String {
    func trimFrontAndBackWhitespaces() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = trimmed.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        let joinedWord = words.joined(separator: " ")
        return joinedWord
    }
}
