//
//  String+Localized.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import Foundation

extension String {
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    public func localized(with arguments: [String]) -> String {
        return String(format: self.localized(), locale: nil, arguments: arguments)
    }
}
