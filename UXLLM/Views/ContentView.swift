//
//  ContentView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            InputContainerView(viewModel: viewModel.inputContainerViewModel)
            
            StartLLMButtonView(isLoading: viewModel.isLoading) {
                viewModel.startGeneratingUsabilityIssues()
            }
            .offset(y: -BasicRoundButtonStyle.dimension/2)
            
            OutputContainerView(error: viewModel.errorText,
                                usabilityIssuesText: viewModel.llmOutput,
                                isLoading: viewModel.isLoading)
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMCaller(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(width: 800, height: 600)
}
