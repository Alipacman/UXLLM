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
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.leading)
                .leftAlignWithHStack()
            
            TextEditorWithPlaceholder(placeholder: placeholder, text: $text)
                .onChange(of: text) {
                    onSave(text)
                }
                .font(.body)
        }
    }
}

#Preview {
    TitleAndTextInputView(title: "What is the app about?", 
                          placeholder: "A fitness tracking app...",
                          text: .constant("A fitness tracker app"),
                          onSave: { _ in })
}
