//
//  InputContainerBackgroundView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct InputContainerBackgroundView: View {
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(colors: [Color("BackgroundGradient1"),
                                        Color("BackgroundGradient2")],
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .clipShape(
                .rect(
                    bottomLeadingRadius: 16,
                    bottomTrailingRadius: 16
                )
            )
    }
}

// MARK: - Preview
#Preview {
    InputContainerBackgroundView()
}
