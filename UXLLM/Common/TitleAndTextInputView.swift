//
//  TitleAndTextInputView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct TitleAndTextInputView: View {
    
    let title: String
    let userDefaultsKey: String?
    @Binding var text: String
    
    init(title: String, text: Binding<String>, userDefaultsKeyToSaveText: String? = nil) {
        self.title = title
        self._text = text
        self.userDefaultsKey = userDefaultsKeyToSaveText
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.leading)
                .leftAlignWithHStack()
            
            TextEditor(text: $text)
                .onChange(of: text) {
                    if let userDefaultsKey {
                        UserDefaults.standard.set(text, forKey: userDefaultsKey)
                    }
                }
                .font(.body)
        }
    }
}

#Preview {
    TitleAndTextInputView(title: "What is the app about?", text: .constant("A fitness tracker app"))
}
