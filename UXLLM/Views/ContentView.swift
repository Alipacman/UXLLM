//
//  ContentView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

fileprivate let appContextKey = "AppContextKey"
fileprivate let componentDescriptionKey = "ComponentDescriptionKey"
fileprivate let sourceCodeKey = "SourceCodeKey"

struct ContentView: View {
    
    @State var appContext: String = UserDefaults.standard.string(forKey: appContextKey) ?? ""
    @State var userTask: String = UserDefaults.standard.string(forKey: componentDescriptionKey) ?? ""
    @State var sourceCode: String = UserDefaults.standard.string(forKey: sourceCodeKey) ?? ""
    @State var nsImage: NSImage? = nil
    @State var model: LLMNetworkService.GPTModel = .gpt35Turbo
    
    @State var responseMessage: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                HStack(spacing: 120) {
                    VStack(spacing: 16) {
                        TitleAndTextInputView(title: "My app is about...", text: $appContext,
                                              userDefaultsKeyToSaveText: appContextKey)
                            .frame(height: 100)
                        
                        TitleAndTextInputView(title: "The user's task in this view is about...?", text: $userTask,
                                              userDefaultsKeyToSaveText: componentDescriptionKey)
                            .frame(height: 100)
                        
                        TitleAndTextInputView(title: "Source Code", text: $sourceCode,
                                              userDefaultsKeyToSaveText: sourceCodeKey)
                            .frame(height: 400)
                    }
                    
                    ImageDropArea(nsImage: $nsImage)
                }
                
                ModelChoosingView(selectedModel: $model)
                
                startButton
                
                CopyPromptView(prompt: getPrompt())
                
                FeedbackView(feedback: responseMessage)
            }
            .padding(32)
        }
    }
    
    private var startButton: some View {
        Button {
            makeCall()
        } label: {
            Text("Start")
        }
        .buttonStyle(PrimaryButtonStyle(isLoading: isLoading))
    }
    

    
    private func makeCall() {
        Task {
            do {
                self.isLoading = true
                let base64EncodedImage = nsImage?.jpegData()?.base64EncodedString()
                let response = try await LLMNetworkService.shared.call(prompt: getPrompt(),
                                                                       model: model,
                                                                       base64EncodedImage: base64EncodedImage)
                self.responseMessage = response
                self.isLoading = false
            } catch {
                self.responseMessage = (error as? AppError)?.description ?? error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func getPrompt() -> String {
        let configuration = PromptGenerator.Configuration(appContext: appContext, task: userTask, sourceCode: sourceCode)
        return PromptGenerator.generatePrompt(with: configuration)
    }
}

#Preview {
    ContentView()
}
