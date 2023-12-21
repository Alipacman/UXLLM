//
//  PrimaryButtonStyle.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct BasicRoundButtonStyle: ButtonStyle {
    
    static let dimension: CGFloat = 84
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
                Color("BasicRoundButtonColor")
            )
            .overlay(
                Circle().stroke(Color("BasicRoundButtonColorStroke"), lineWidth: 8)
            )
            .clipShape(
                Circle()
            )
            .opacity(isLoading ? 0.8 : 1.0)
            .blur(radius: isLoading ? 3.0 : 0.0)
            .shadow(color: .black.opacity(0.1), radius: 4.0, y: 2.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Start")
    }
    .buttonStyle(BasicRoundButtonStyle(isLoading: false))
    .frame(width: 200, height: 200)
    .background( InputContainerBackgroundView() )
}
