//
//  FeedbackView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct FeedbackView: View {
    let feedback: String
    
    var body: some View {
        Text(feedback)
            .font(.body)
    }
}

#Preview {
    FeedbackView(feedback: "WOW")
}
