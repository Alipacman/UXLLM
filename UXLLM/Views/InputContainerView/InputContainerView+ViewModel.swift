//
//  InputContainerView+ViewModel.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

extension InputContainerView {
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
    
        @Published var inputConfiguration: InputConfiguration = .init()
        internal let imageCompressor: ImageCompressor
            
        // MARK: - Init
        init(inputConfiguration: InputConfiguration = .init(),
             imageCompressor: ImageCompressor) {
            self.inputConfiguration = inputConfiguration
            self.imageCompressor = imageCompressor
        }
    }
}
