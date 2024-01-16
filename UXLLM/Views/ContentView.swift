//
//  ContentView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            InputContainerView(viewModel: viewModel.inputContainerViewModel)
            
            StartLLMButtonView(isLoading: viewModel.isLoading) {
                viewModel.startGeneratingUsabilityIssues()
            }
            .offset(y: -BasicRoundButtonStyle.dimension/2)
            .zIndex(2.0)
            
            OutputContainerView(isLoading: viewModel.isLoading,
                                usabilityIssuesText: viewModel.llmOutput,
                                error: viewModel.errorText)
            .offset(y: -BasicRoundButtonStyle.dimension)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMPreviewHelper.generateMockedLLM(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(height: 1100)
}
