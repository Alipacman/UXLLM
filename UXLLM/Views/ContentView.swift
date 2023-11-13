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
    
    @State var responseMessage: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TitleAndTextInputView(title: "What is the app about?", text: $appContext)
                    .frame(height: 100)
                
                TitleAndTextInputView(title: "What is the users task in your current component?", text: $userTask)
                    .frame(height: 100)
                
                TitleAndTextInputView(title: "Source Code", text: $sourceCode)
                    .frame(height: 400)
                
                startButton
                FeedbackView(feedback: responseMessage)
            }
            .padding()
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
                let prompt = PromptGenerator.generatePrompt(with: .init(appContext: appContext,
                                                                        task: userTask,
                                                                        sourceCode: sourceCode))
                let response = try await NetworkService.shared.testRequest(prompt: prompt)
                self.responseMessage = response.choices.first?.message.content ?? "Failed Parse"
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
