//
//  OutputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct OutputContainerView: View {
    
    // MARK: - Properties
    let isLoading: Bool
    let usabilityIssuesText: String?
    let error: String?
    
    private var shouldShow: Bool {
        isLoading || usabilityIssuesText != nil || error != nil
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            if isLoading {
                SinebowAnimationView(shaderSineWidth: 300,
                                     shaderSineHeight: 100,
                                     timeMultier: 2.0)
                .frame(height: 250)
                .padding(.top, 40)
            } else if let usabilityIssuesText {
                UsabilityIssuePresentationView(usabilityIssuesText: usabilityIssuesText)
                    .padding(.horizontal, 20)
            } else if let error {
                ErrorView(error: error)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.bottom, 10)
        .frame(width: 700)
        .frame(minHeight: 10) // Neccessary for non buggy scale effect animation
        .background(OutputContainerBackgroundView(adjustContrastForText: !isLoading))
        .scaleEffect(x: 1, y: shouldShow ? 1 : 0, anchor: .top)
        .animation(.easeInOut(duration: 0.6) , value: shouldShow)
    }
}

// MARK: - Preview
#Preview {
    OutputContainerView(isLoading: true,
                        usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues,
                        error: nil)
    .frame(width: 800, height: 500)
}
