//
//  Constants.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import Foundation

struct Constants {
    static let useMockedService: Bool = true
    
    static let maxTokens: Int? = 3000
    static let temperature: CGFloat = 0.7
    static let imageDetail: String = "low" // "high"
    
    static let numberOfPredictedUsabilityIssues = 10
    
    static let defaultOpenAILLM = OpenAILLM.gpt3Turbo
    static let hideLLMSelection = true
    
    static let imageCompressionSize = CGSize(width: 240, height: 510)
    static let imageRatio = 2.16 // iPhone 13 Display
    
    static let printNetworkData = true
}
