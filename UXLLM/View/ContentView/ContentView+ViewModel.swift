//
//  ContentView+ViewModel.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        
        // MARK: - Properties
        internal struct InputConfiguration {
            var appOverview: String = ""
            var userTask: String = ""
            var sourceCode: String = ""
            var nsImage: NSImage? = nil
            var llmModel: OpenAILLM = Constants.defaultOpenAILLM
            
            func generatePromptConfiguration() -> PromptConfiguration {
                .init(appOverview: appOverview, userTask: userTask, sourceCode: sourceCode, hasImage: nsImage == nil)
            }
        }
    
        @Published internal var inputConfiguration: InputConfiguration = .init()
        @Published internal var llmOutput: String? = nil
        @Published internal var errorText: String? = nil
        @Published internal var isLoading: Bool = false
        
        internal let llmCaller: LLMCaller
        internal let promptGenerator: PromptGenerator
        internal let imageCompressor: ImageCompressor
        
        // MARK: - Init
        init(llmCaller: LLMCaller,
             promptGenerator: PromptGenerator,
             imageCompressor: ImageCompressor) {
            self.llmCaller = llmCaller
            self.promptGenerator = promptGenerator
            self.imageCompressor = imageCompressor
        }
        
        // MARK: - Interface
        func startGeneratingUsabilityIssues() {
            Task {
                do {
                    changePresentationState(loadingActive: true)
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
                withAnimation(Animation.easeInOut(duration: 3.0)) {
                    self.isLoading = loadingActive
                }
            }
        }
    }
}
