//
//  CopyPromptView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 14.11.23.
//

import SwiftUI

struct CopyPromptView: View {
    
    let prompt: String
    @State private var showSuccessMessage = false

    var body: some View {
        VStack(spacing: 32) {
            copyPromptButton
            successText
        }
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
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(prompt, forType: .string)
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

struct CopyPromptView_Previews: PreviewProvider {
    static var previews: some View {
        CopyPromptView(prompt: "Example prompt")
    }
}

#Preview {
    CopyPromptView(prompt: "")
}
