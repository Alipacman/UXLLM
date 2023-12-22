//
//  String+Localized.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
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
