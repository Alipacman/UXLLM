//
//  UXLLMApp.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

@main
struct UXLLMApp: App {
    
    // MARK: - Properties
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: Self.generateConfiguredContentViewModel())
                .background(TransparentWindow())
        }
    }
    
    // MARK: - Helper
    private static func generateConfiguredContentViewModel() -> ContentView.ViewModel {
        Constants.useMockedServices ? contentViewViewModelWithMockedServices() : contentViewViewModel()
    }
    
    private static func contentViewViewModel() -> ContentView.ViewModel {
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
