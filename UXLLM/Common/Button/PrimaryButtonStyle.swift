//
//  PrimaryButtonStyle.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    static let height: CGFloat = 36
    private let width: CGFloat
    private let isLoading: Bool
    
    init(width: CGFloat = 240, isLoading: Bool = false) {
        self.width = width
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .tint(.white)
                    .padding()
            } else {
                configuration.label
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .frame(width: width, height: Self.height)
        .background(
            LinearGradient(gradient: Gradient(colors: [.orange, .red]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 100)
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
