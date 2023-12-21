//
//  ImageDropContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

struct TitledContainerView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text(title)
                .uxLLMTitleTextStyle()
                .multilineTextAlignment(.leading)
                .leftAlignWithHStack()
            
            content
        }
    }
}
