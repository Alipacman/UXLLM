//
//  ContentView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var appContext: String = ""
    @State var userTask: String = ""
    @State var sourceCode: String = ""
    @State var nsImage: NSImage? = nil
    
    @State var responseMessage: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                HStack(spacing: 120) {
                    VStack(spacing: 16) {
                        TitleAndTextInputView(title: "What is the app about?", text: $appContext)
                            .frame(height: 100)
                        
                        TitleAndTextInputView(title: "What is the users task in your current component?", text: $userTask)
                            .frame(height: 100)
                        
                        TitleAndTextInputView(title: "Source Code", text: $sourceCode)
                            .frame(height: 400)
                    }
                    
                    ImageDropArea(nsImage: $nsImage)
                }
                
                startButton
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
                let configuration = PromptGenerator.Configuration(appContext: appContext, task: userTask, sourceCode: sourceCode)
                let prompt = PromptGenerator.generatePrompt(with: configuration)
                let base64EncodedImage = ImageProcessor.convertToBase64(nsImage: nsImage)
                let response = try await LLMNetworkService.shared.call(prompt: prompt, base64EncodedImage: base64EncodedImage)
                self.responseMessage = response.prettyResponse
                self.isLoading = false
            } catch {
                self.responseMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
