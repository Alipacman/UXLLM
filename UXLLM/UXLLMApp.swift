//
//  UXLLMApp.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

@main
struct UXLLMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: Self.generateConfiguredViewModel())
                .background(TransparentWindow())
        }
    }
    // MARK: - Helper
    private static func generateConfiguredViewModel() -> ContentView.ViewModel {
        Constants.useMockedService ? contentViewViewModelWithMockedService() : contentViewViewModel()
    }
    
    private static func contentViewViewModel() -> ContentView.ViewModel {
        .init(llmCaller: OpenAILLMCaller(),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: TinfyImageCompressorNetworkService()
        )
    }
    
    private static func contentViewViewModelWithMockedService() -> ContentView.ViewModel {
        .init(llmCaller: MockedLLMCaller(),
              promptGenerator: BasicPromptGenerator(),
              imageCompressor: MockedImageCompressor()
        )
    }
}
