//
//  Constants.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import Foundation

struct Constants {
    static let defaultModel: LLMNetworkService.GPTModel = .gpt35Turbo
    static let temperature: CGFloat = 0.7
    static let byteLimit: Int = 30000 // 30kb
}
