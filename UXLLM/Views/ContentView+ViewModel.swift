//
//  ContentView+ViewModel.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        
        // MARK: - Properties
        @Published internal var llmOutput: String? = nil
        @Published internal var errorText: String? = nil
        @Published internal var isLoading: Bool = false
        
        internal let inputContainerViewModel: InputContainerView.ViewModel
        
        internal let llmCaller: LLMCaller
        internal let promptGenerator: PromptGenerator
        
        
        // MARK: - Init
        init(llmCaller: LLMCaller,
             promptGenerator: PromptGenerator,
             imageCompressor: ImageCompressor) {
            self.llmCaller = llmCaller
            self.promptGenerator = promptGenerator
            self.inputContainerViewModel = .init(imageCompressor: imageCompressor)
        }
        
        // MARK: - Interface
        func startGeneratingUsabilityIssues() {
            Task {
                do {
                    changePresentationState(loadingActive: true)
                    let inputConfiguration = inputContainerViewModel.inputConfiguration
                    let base64EncodedImage = inputConfiguration.nsImage?.jpegData()?.base64EncodedString()
                    let promptConfiguration = inputConfiguration.generatePromptConfiguration()
                    let response = try await llmCaller.call(with: .init(modelId: inputConfiguration.llmModel.id,
                                                                        base64EncodedImage: base64EncodedImage,
                                                                        systemContent: promptGenerator.generateSystemContent(),
                                                                        userContent: promptGenerator.generateUserContent(with: promptConfiguration)))
                    changePresentationState(loadingActive: false, llmOutput: response)
                } catch {
                    changePresentationState(loadingActive: false,
                                            errorText: (error as? AppError)?.description ?? error.localizedDescription)

                }
            }
        }
        
        // MARK: - Helper
        private func changePresentationState(loadingActive: Bool,
                                             llmOutput: String? = nil,
                                             errorText: String? = nil) {
            DispatchQueue.main.async {
                self.llmOutput = llmOutput
                self.errorText = errorText
                
                withAnimation(Animation.easeInOut(duration: 0.6)) {
                    self.isLoading = loadingActive
                }
            }
        }
    }
}

// MARK: - Extensions
private extension InputContainerView.ViewModel.InputConfiguration {
    func generatePromptConfiguration() -> PromptConfiguration {
        .init(appOverview: appOverview, userTask: userTask, sourceCode: sourceCode, hasImage: nsImage == nil)
    }
}
