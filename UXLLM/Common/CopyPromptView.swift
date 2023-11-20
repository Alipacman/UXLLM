//
//  CopyPromptView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import SwiftUI

struct CopyPromptView: View {
    
    var promptGeneration: ((Bool) -> String)?
    @State private var showSuccessMessage = false
    @State private var withImagePrompt = false

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                copyPromptButton
                withImagePromptToggle
            }
            successText
        }
    }
    
    private var withImagePromptToggle: some View {
        Toggle(isOn: $withImagePrompt) {
            Text("With Image")
        }
        .toggleStyle(.checkbox)

    }
    
    private var successText: some View {
        Group {
            if showSuccessMessage {
                Text("Successfully Copied")
                    .transition(.opacity)
            }
        }
    }
    
    private var copyPromptButton: some View {
        Button {
            guard let prompt = promptGeneration?(withImagePrompt) else { return }
            let addedSystemStuff = PromptGenerator.generateSystemRole() + ":\n\n" + prompt
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(addedSystemStuff, forType: .string)
            showAndHideText()
        } label: {
            Text("Copy Prompt")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    private func showAndHideText() {
        withAnimation {
            showSuccessMessage = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showSuccessMessage = false
            }
        }
    }
}
