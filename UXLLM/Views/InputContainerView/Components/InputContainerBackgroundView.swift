//
//  InputContainerBackgroundView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct InputContainerBackgroundView: View {
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

#Preview {
    InputContainerBackgroundView()
}
