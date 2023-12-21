//
//  ContentView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
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
                
                textFields
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
    
    private var textFields: some View {
        VStack(spacing: 40) {
            TitleAndTextInputView(title: "App Overview Input Title".localized(),
                                  placeholder: "App Overview Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.appOverview) { newValue in
                viewModel.persist(input: .appOverview, value: newValue)
            }
                                  .frame(height: 130)
            
            TitleAndTextInputView(title: "User Task Input Title".localized(),
                                  placeholder: "User Task Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.userTask) { newValue in
                viewModel.persist(input: .userTask, value: newValue)
            }
                                  .frame(height: 130)
            
            TitleAndTextInputView(title: "Source Code Input Title".localized(), 
                                  placeholder: "Source Code Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.sourceCode) { newValue in
                viewModel.persist(input: .sourceCode, value: newValue)
            }
                                  .frame(height: 360)
        }
        .padding(24)
        .styledBackground(mode: .light)
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

#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMCaller(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(width: 800, height: 600)
}
