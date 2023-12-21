//
//  OutputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct OutputContainerView: View {
    
    let isLoading: Bool
    let usabilityIssuesText: String?
    let error: String?
    
    private var shouldShow: Bool {
        isLoading || usabilityIssuesText != nil || error != nil
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                SinebowAnimationView(shaderSineWidth: 200,
                                     shaderSineHeight: 20,
                                     timeMultier: 1.5)
                .frame(height: 200)
                .padding(.top, 60)
            } else if let usabilityIssuesText {
                UsabilityIssuePresentationView(usabilityIssuesText: usabilityIssuesText)
            } else if let error {
                ErrorView(error: error)
            }
        }
        .padding([.top, .bottom], 40)
        .frame(width: 600)
        .background(OutputContainerBackgroundView())
        .scaleEffect(x: 1, y: shouldShow ? 1 : 0, anchor: .top)
        .animation(.easeInOut(duration: 0.5), value: shouldShow)
    }
}

#Preview {
    OutputContainerView(isLoading: false,
                        usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues,
                        error: nil)
    .frame(width: 800, height: 500)
}
