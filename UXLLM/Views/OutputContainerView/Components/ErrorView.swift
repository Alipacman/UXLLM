//
//  ErrorView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct ErrorView: View {
    
    let error: String
    
    var body: some View {
        Text(error)
            .foregroundStyle(Color("TintColor"))
            .uxLLMBodyTextStyle()
    }
}

#Preview {
    ErrorView(error: "Failed Fetching")
}
