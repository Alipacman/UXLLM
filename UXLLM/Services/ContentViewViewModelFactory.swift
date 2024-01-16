//
//  ContentViewViewModelFactory.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.01.24.
//

import Foundation
import LLMCaller

struct ContentViewViewModelFactory {
    
    // MARK: - Interface
    static func generateConfiguredContentViewViewModel() -> ContentView.ViewModel {
        Constants.useMockedServices ? contentViewViewModelWithMockedServices() : contentViewViewModelWithServices()
    }
    
    // MARK: - Helper
    private static func contentViewViewModelWithServices() -> ContentView.ViewModel {
        .init(llmCaller: OpenAILLMCaller(openAIKey: LocalConfiguration.openAIKey),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: TinfyImageCompressorNetworkService(tinyPNGkey: LocalConfiguration.tinyPNGkey)
        )
    }
    
    private static func contentViewViewModelWithMockedServices() -> ContentView.ViewModel {
        .init(llmCaller: MockedUsabilityIssuesLLMHelper.generateMockedLLM(),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: MockedImageCompressor()
        )
    }
}
