//
//  TextEditorWithPlaceholder.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .overlay (
                Text(placeholder)
                    .multilineTextAlignment(.leading)
                    .opacity(text.isEmpty ? 0.5 : 0.0)
                    .leftAlignWithHStack()
                    .topAlignWithVStack()
                    .padding(.leading, 8)
            )
    }
}


#Preview {
    TextEditorWithPlaceholder(placeholder: "Placeholder", text: .constant("Test"))
}
