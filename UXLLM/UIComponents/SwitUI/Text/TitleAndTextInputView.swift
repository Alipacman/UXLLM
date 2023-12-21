//
//  TitleAndTextInputView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct TitleAndTextInputView: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    let onSave: (String) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            TitledContainerView(title: title, accessoryQuestionMark: true) {
                TextEditorWithPlaceholder(placeholder: placeholder, text: $text)
                    .uxLLMBodyTextStyle()
                    .padding(16)
                    .glossyRoundedRectangleBackground(mode: .dark)
                    .onChange(of: text) {
                        onSave(text)
                    }
            }
        }
    }
}

#Preview {
    TitleAndTextInputView(title: "What is the app about?", 
                          placeholder: "A fitness tracking app...",
                          text: .constant("A fitness tracker app"),
                          onSave: { _ in })
}
