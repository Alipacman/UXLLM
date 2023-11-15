//
//  Constants.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import Foundation

struct Constants {
    static let defaultModel: LLMNetworkService.GPTModel = .gpt4TurboVision
    static let maxTokens = 4000
    static let temperature: CGFloat = 0.7
    static let byteLimit: Int = 30000 // 30kb
    static let sizeToResizeTo = CGSize(width: 240, height: 510)
    
    static let printNetworkData = true
}
