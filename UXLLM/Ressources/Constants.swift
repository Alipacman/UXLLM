//
//  Constants.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import Foundation

struct Constants {
    static let useMockedServices: Bool = false
    
    static let defaultOpenAILLM = OpenAILLM.gpt4TurboVision
    static let numberOfPredictedUsabilityIssues = 10
    static let maxTokens: Int? = 3000
    static let temperature: CGFloat = 0.7
    static let imageDetail: String = "low" // "high"
    
    static let imageRatio = 2.16 // iPhone 13 Display
    static let imageCompressionSize = CGSize(width: 240, height: 518)
    
    static let printNetworkData = false
}
