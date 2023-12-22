//
//  UsabilityIssuePresentationView.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct UsabilityIssuePresentationView: View {
    
    // MARK: - Properties
    let usabilityIssuesText: String
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(usabilityIssuesText)
                .foregroundStyle(Color("TintColor"))
                .uxLLMBodyTextStyle()
        }
    }
}

// MARK: - Preview
#Preview {
    UsabilityIssuePresentationView(usabilityIssuesText: MockedLLMCaller.mockedUsabilityIssues)
}
