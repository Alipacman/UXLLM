//
//  OutputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct OutputContainerView: View {
    
    let error: String?
    let usabilityIssuesText: String?
    let isLoading: Bool?
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    OutputContainerView(error: nil, usabilityIssuesText: nil, isLoading: nil)
}
