//
//  OpenAIModel.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import Foundation

enum OpenAILLM: Identifiable, CaseIterable {
    case gpt3Turbo, gpt4Turbo, gpt4TurboVision
    
    var id: String { self.identifier }
    
    var presentationName: String {
        switch self {
        case .gpt3Turbo: return "GPT-3.5 Turbo"
        case .gpt4Turbo: return "GPT-4 Turbo"
        case .gpt4TurboVision: return "GPT-4 Turbo Vision"
        }
    }
    
    fileprivate var identifier: String {
        switch self {
        case .gpt3Turbo: return "gpt-3.5-turbo-1106" // $0.0010 / $0.0020 per 1k tokens
        case .gpt4Turbo: return "gpt-4-1106-preview"
        case .gpt4TurboVision: return "gpt-4-vision-preview" // $0.01 Input / $0.03 Output per 1k tokens
        }
    }
}
