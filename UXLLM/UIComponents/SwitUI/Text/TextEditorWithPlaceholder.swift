//
//  TextEditorWithPlaceholder.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    
    // MARK: - Properties
    let placeholder: String
    @Binding var text: String
    
    // MARK: - Body
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

// MARK: - Preview
#Preview {
    TextEditorWithPlaceholder(placeholder: "Placeholder", text: .constant("Test"))
}
