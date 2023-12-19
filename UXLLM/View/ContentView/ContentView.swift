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
        VStack(spacing: 40) {
            HStack(spacing: 80) {
                Spacer()
                VStack {
                    Text("Intro Text".localized())
                        .multilineTextAlignment(.leading)
                        .uxLLMTitleTextStyle()
                        .leftAlignWithHStack()
                    
                    Spacer(minLength: 0)
                    
                    TitleBackgroundedContainerView(title: "Image Drop Title".localized()) {
                        ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                                      nsImage: $viewModel.inputConfiguration.nsImage)
                    }
                }
                .frame(width: 500, height: 750)
                
                textFields
                    .frame(width: 500)
                Spacer()
            }
            
            if !Constants.hideLLMSelection {
                OpenAILLMModelChoosingView(selectedModel: $viewModel.inputConfiguration.llmModel)
            }
            
            startButton
            
            UsabilityIssuePresentationView(usabilityIssuesText: viewModel.llmOutput ?? "")
        }
        .padding(32)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [Color("BackgroundGradient1"),
                                            Color("BackgroundGradient2")],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
        )
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
                                  .frame(height: 362)
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
        .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.isLoading))
    }
}

#Preview {
    ContentView(viewModel: .init(llmCaller: MockedLLMCaller(),
                                 promptGenerator: BasicPromptGenerator(),
                                 imageCompressor: MockedImageCompressor()))
    .frame(width: 800, height: 600)
}
