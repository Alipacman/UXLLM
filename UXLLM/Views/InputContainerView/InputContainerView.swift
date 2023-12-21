//
//  InputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct InputContainerView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
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
                    .glossyRoundedRectangleBackground(mode: .light)
                }
                .frame(width: 500, height: 750)
                
                PersistingInputTextFieldsView(appOverview: $viewModel.inputConfiguration.appOverview,
                                              userTask: $viewModel.inputConfiguration.userTask,
                                              sourceCode: $viewModel.inputConfiguration.sourceCode)
                .padding(24)
                .glossyRoundedRectangleBackground(mode: .light)
                .frame(width: 500)
                
                Spacer()
            }
            
            if !Constants.hideLLMSelection {
                OpenAILLMModelChoosingView(selectedModel: $viewModel.inputConfiguration.llmModel)
            }
        }
        .padding(40)
        .background(
            InputContainerBackgroundView()
        )
        .frame(height: 130 + 130 + 360 + 40 + 40 + 24 + 24 + 40 + 40)
    }
}

#Preview {
    InputContainerView(viewModel: .init(imageCompressor: MockedImageCompressor()))
}
