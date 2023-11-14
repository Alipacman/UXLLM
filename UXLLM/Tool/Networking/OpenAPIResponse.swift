//
//  OpenAPIResponse.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct OpenAPIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
}

struct Usage: Codable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

struct Choice: Codable {
    let message: Message
    let finishReason: String
    let index: Int

    enum CodingKeys: String, CodingKey {
        case message
        case finishReason = "finish_reason"
        case index
    }
}

struct Message: Codable {
    let role: String
    let content: String
}

extension OpenAPIResponse {
    // Input e.g. "0.01" -> $0.01 Input / "0.03" - > $0.03 Output per 1k tokens
    func calculatePrice(inputTokenPricePer1k: CGFloat, outputTokenPricePer1k: CGFloat) -> String {
        let promptTokenCost = (CGFloat(usage.promptTokens) / 1000) * inputTokenPricePer1k
        let completionTokenCost = (CGFloat(usage.completionTokens) / 1000) * outputTokenPricePer1k
        let totalCost = promptTokenCost + completionTokenCost
        return "The Request has cost you $\(totalCost)"
    }
}

// TODO: -
extension OpenAPIResponse {
    var prettyResponse: String {
        choices.first?.message.content ?? "Failed Parse"
    }
}
