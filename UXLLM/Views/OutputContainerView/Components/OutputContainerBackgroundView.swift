//
//  OutputContainerBackgroundView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct OutputContainerBackgroundView: View {
    var body: some View {
        Rectangle()
            .fill(
                Color.black
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
    OutputContainerBackgroundView()
}
