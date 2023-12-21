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
            startButton
                .offset(y: -BasicRoundButtonStyle.dimension/2)
            if viewModel.isLoading && viewModel.llmOutput != nil {
                UsabilityIssuePresentationView(isLoading: viewModel.isLoading,
                                               usabilityIssuesText: viewModel.llmOutput)
            }
            
            Spacer()
        }
    }
    
    private var startButton: some View {
        Button {
            viewModel.startGeneratingUsabilityIssues()
        } label: {
            Text("Start Button Title".localized())
        }
        .buttonStyle(BasicRoundButtonStyle(isLoading: viewModel.isLoading))
    }
}

// MARK: - Preview
#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMCaller(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(width: 800, height: 600)
}
