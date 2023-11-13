//
//  TitleAndTextInputView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct TitleAndTextInputView: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.leading)
                .leftAlignWithHStack()
            
            TextEditor(text: $text)
                .font(.body)
        }
    }
}

#Preview {
    TitleAndTextInputView(title: "What is the app about?", text: .constant("A fitness tracker app"))
}
