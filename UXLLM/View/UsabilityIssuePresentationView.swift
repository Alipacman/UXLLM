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
            .font(.body)
    }
}

#Preview {
    UsabilityIssuePresentationView(usabilityIssuesText: "...")
}
