//
//  SinebowAnimation.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

struct SinebowAnimationView: View {
    @State private var startTime = Date.now
    
    let shaderSineWidth: CGFloat
    let shaderSineHeight: CGFloat
    let timeMultier: CGFloat
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            Rectangle()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.sinebow(
                                .float2(.init(width: shaderSineWidth,
                                              height: shaderSineHeight)),
                                .float(elapsedTime * timeMultier)
                            )
                        )
                }
        }
    }
}

#Preview {
    SinebowAnimationView(shaderSineWidth: 200, shaderSineHeight: 100,
                         timeMultier: 1.5)
}
