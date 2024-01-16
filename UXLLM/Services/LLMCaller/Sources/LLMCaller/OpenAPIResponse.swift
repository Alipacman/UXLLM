//
//  OpenAPIResponse.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct Usage: Codable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
}

struct Message: Codable {
    let role: String
    let content: String
}

struct FinishDetails: Codable {
    let type: String
}

struct Choice: Codable {
    var message: Message
    var index: Int
}

struct OpenAPIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
    
    var prettyResponse: String {
        choices.first?.message.content ?? "Failed Parse"
    }
}
