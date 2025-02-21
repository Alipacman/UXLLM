//
//  ErrorView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct ErrorView: View {
    
    // MARK: - Properties
    let error: String
    
    // MARK: - Body
    var body: some View {
        Text(error)
            .foregroundStyle(Color(.tint))
            .uxLLMBodyTextStyle()
    }
}

// MARK: - Preview
#Preview {
    ErrorView(error: "Failed Fetching")
        .padding(30)
        .background(OutputContainerBackgroundView(adjustContrastForText: true))
}
