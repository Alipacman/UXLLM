//
//  SinebowAnimation.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

struct SinebowAnimationView: View {
    @State private var startTime = Date.now
    
    let width: CGFloat
    let heigth: CGFloat
    let timeMultier: CGFloat
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .frame(width: 100, height: 100)
    }
}

#Preview {
    SinebowAnimationView(width: 200, heigth: 100, timeMultier: 3.0)
}
