//
//  ErrorView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct ErrorView: View {
    
    // MARK: - Properties
    let error: String
    
    // MARK: - Body
    var body: some View {
        Text(error)
            .foregroundStyle(Color("TintColor"))
            .uxLLMBodyTextStyle()
    }
}

// MARK: - Preview
#Preview {
    ErrorView(error: "Failed Fetching")
}
