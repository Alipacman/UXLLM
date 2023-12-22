//
//  OutputContainerBackgroundView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct OutputContainerBackgroundView: View {
    
    // MARK: - Properties
    let adjustContrastForText: Bool
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .fill(
                adjustContrastForText ? Color("OutputBackgroundColor") : .black
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
    OutputContainerBackgroundView(adjustContrastForText: false)
}
