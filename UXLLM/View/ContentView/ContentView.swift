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
            content
            startButton
                .offset(y: -BasicRoundButtonStyle.dimension/2)
            if viewModel.isLoading && viewModel.llmOutput != nil {
                UsabilityIssuePresentationView(isLoading: viewModel.isLoading,
                                               usabilityIssuesText: viewModel.llmOutput)
            }
            
            Spacer()
        }
    }
    
    private var content: some View {
        VStack(spacing: 40) {
            HStack(spacing: 80) {
                Spacer()
                VStack {
                    
                    TitledContainerView(title: "Intro Text".localized()) { }
                    Spacer(minLength: 0)
                    
                    TitledContainerView(title: "Image Drop Title".localized()) {
                        ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                                      nsImage: $viewModel.inputConfiguration.nsImage)
                    }
                    .padding(24)
                    .styledBackground(mode: .light)
                }
                .frame(width: 500, height: 750)
                
                PersistingInputTextFieldsView(appOverview: $viewModel.inputConfiguration.appOverview,
                                              userTask: $viewModel.inputConfiguration.userTask,
                                              sourceCode: $viewModel.inputConfiguration.sourceCode)
                .padding(24)
                .styledBackground(mode: .light)
                .frame(width: 500)
                
                Spacer()
            }
            
            if !Constants.hideLLMSelection {
                OpenAILLMModelChoosingView(selectedModel: $viewModel.inputConfiguration.llmModel)
            }
        }
        .padding(40)
        .background(
            InputBackgroundView()
        )
        .frame(height: 130 + 130 + 360 + 40 + 40 + 24 + 24 + 40 + 40)
    }
    
    private var startButton: some View {
        Button {
            viewModel.startGeneratingUsabilityIssues()
        } label: {
            Text("Start")
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
