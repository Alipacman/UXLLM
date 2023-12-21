//
//  UsabilityIssuePresentationView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct UsabilityIssuePresentationView: View {
    
    @State var isLoading: Bool
    var usabilityIssuesText: String?
    
    var body: some View {
        VStack {
            if isLoading {
                animationView
                    .frame(width: 500, height: 200)
                    .transition(.opacity)
            } else {
                textView
                    .transition(.opacity)
            }
        }
        .background(Color.black)
        .transition(.scale)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 3.0)) {
                    self.isLoading = false
                }
            }
        }
    }
    
    private var animationView: some View {
        SinebowAnimationView(width: 200, heigth: 20, timeMultier: 1.5)
            .frame(width: 500, height: 500)
            .offset(y: 200)
    }
    
    private var textView: some View {
        Text(usabilityIssuesText ?? "")
            .uxLLMBodyTextStyle()
            .multilineTextAlignment(.leading)
            .padding()
    }
}

#Preview {
    UsabilityIssuePresentationView(isLoading: true,
                                   usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues)
}
