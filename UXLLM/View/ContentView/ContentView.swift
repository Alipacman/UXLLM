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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                HStack(spacing: 120) {
                    VStack(spacing: 40) {
                        Text("Intro Text".localized())
                            .uxLLMTitleTextStyle()
                            .multilineTextAlignment(.leading)
                            .leftAlignWithHStack()
                        
                        TitleBackgroundedContainerView(title: "Image Drop Title".localized()) {
                            ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                                          nsImage: $viewModel.inputConfiguration.nsImage)
                        }
                    }
                    textFields
                }
                
                OpenAILLMModelChoosingView(selectedModel: $viewModel.inputConfiguration.llmModel)
                
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
                                  .frame(height: 400)
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
