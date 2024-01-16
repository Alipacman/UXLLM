//
//  MockedPreviewHelper.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 16.01.24.
//

import LLMCaller

// For preview generation it would not be clean to have View's communicate to outer services
struct MockedLLMPreviewHelper {
    static func generateMockedLLM() -> LLMCaller {
        MockedLLMCaller()
    }
    
    static func getMockedUsabilityIssues() -> String {
        MockedLLMCaller.mockedUsabilityIssues
    }
}
