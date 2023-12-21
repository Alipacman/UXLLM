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
        ScrollView(showsIndicators: false) {
            Text(usabilityIssuesText)
                .foregroundStyle(Color("TintColor"))
                .uxLLMBodyTextStyle()
                .lineSpacing(8.0)
        }
    }
}

#Preview {
    UsabilityIssuePresentationView(usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues)
}
