//
//  StartLLMButtonView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct StartLLMButtonView: View {
    
    // MARK: - Properties
    let isLoading: Bool
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            Text("Start Button Title".localized())
        }
        .buttonStyle(BasicRoundButtonStyle(isLoading: isLoading))
        .disabled(isLoading)
    }
}

// MARK: - Preview
#Preview {
    StartLLMButtonView(isLoading: false) { }
        .padding(30)
        .background(InputContainerBackgroundView())
}
