//
//  PrimaryButtonStyle.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct BasicRoundButtonStyle: ButtonStyle {
    
    static let dimension: CGFloat = 100
    private let isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color("TintColor"))
            .uxLLMButtonTitleTextStyle()
            .lineLimit(1)
            .frame(width: Self.dimension,
                   height: Self.dimension)
            .background(
                Color("BackgroundGradient2")
            )
            .clipShape(
                Circle()
            )
            .shadow(color: .black.opacity(0.3), radius: 5.0, y: 2.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
