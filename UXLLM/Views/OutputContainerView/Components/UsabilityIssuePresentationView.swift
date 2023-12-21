//
//  UsabilityIssuePresentationView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct UsabilityIssuePresentationView: View {
    
    let usabilityIssuesText: String
    
    var body: some View {
        Text(usabilityIssuesText)
            .foregroundStyle(Color("TintColor"))
            .uxLLMBodyTextStyle()
            .lineSpacing(10.0)
    }
}

#Preview {
    UsabilityIssuePresentationView(usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues)
}
