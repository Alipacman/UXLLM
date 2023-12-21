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
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            Rectangle()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.sinebow(
                                .float2(.init(width: width, height: heigth)),
                                .float(elapsedTime*timeMultier)
                            )
                        )
                }
        }
    }
}

#Preview {
    SinebowAnimationView(width: 200, heigth: 100, timeMultier: 3.0)
}
