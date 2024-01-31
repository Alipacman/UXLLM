//
//  PromptGeneratorProtocol.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import Foundation

struct PromptConfiguration {
    let appOverview: String
    let userTask: String
    let sourceCode: String?
    let hasImage: Bool
}

protocol PromptGenerator {
    func generateUserContent(with configuration: PromptConfiguration) -> String
    func generateSystemContent() -> String
}
