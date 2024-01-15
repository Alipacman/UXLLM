//
//  ContentViewViewModelFactory.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.01.24.
//

import Foundation

struct ContentViewViewModelFactory {
    
    // MARK: - Interface
    static func generateConfiguredContentViewViewModel() -> ContentView.ViewModel {
        Constants.useMockedServices ? contentViewViewModelWithMockedServices() : contentViewViewModelWithServices()
    }
    
    // MARK: - Helper
    private static func contentViewViewModelWithServices() -> ContentView.ViewModel {
        .init(llmCaller: OpenAILLMCaller(),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: TinfyImageCompressorNetworkService()
        )
    }
    
    private static func contentViewViewModelWithMockedServices() -> ContentView.ViewModel {
        .init(llmCaller: MockedLLMCaller(),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: MockedImageCompressor()
        )
    }
}
