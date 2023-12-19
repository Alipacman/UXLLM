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
        ScrollView {
            VStack(spacing: 40) {
                HStack(spacing: 120) {
                    textFields
                    ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                                  nsImage: $viewModel.inputConfiguration.nsImage)
                }
                
                OpenAILLMModelChoosingView(selectedModel: $viewModel.inputConfiguration.llmModel)
                
                startButton
                
                UsabilityIssuePresentationView(usabilityIssuesText: viewModel.llmOutput ?? "")
            }
            .padding(32)
        }
    }
    
    private var textFields: some View {
        VStack(spacing: 16) {
            TitleAndTextInputView(title: "App Overview Input Title".localized(),
                                  placeholder: "App Overview Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.appOverview) { newValue in
                viewModel.persist(input: .appOverview, value: newValue)
            }
                                  .frame(height: 100)
            
            TitleAndTextInputView(title: "User Task Input Title".localized(),
                                  placeholder: "User Task Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.userTask) { newValue in
                viewModel.persist(input: .userTask, value: newValue)
            }
                                  .frame(height: 100)
            
            TitleAndTextInputView(title: "Source Code Input Title".localized(), 
                                  placeholder: "Source Code Input Placeholder".localized(),
                                  text: $viewModel.inputConfiguration.sourceCode) { newValue in
                viewModel.persist(input: .sourceCode, value: newValue)
            }
                                  .frame(height: 400)
        }
    }
    
    private var startButton: some View {
        Button {
            viewModel.startGeneratingUsabilityIssues()
        } label: {
            Text("Start")
        }
        .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.isLoading))
    }
}

#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMCaller(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(width: 800, height: 600)
}
