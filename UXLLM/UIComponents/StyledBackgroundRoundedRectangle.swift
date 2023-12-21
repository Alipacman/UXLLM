//
//  BlurredBackground.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

struct StyledBackgroundRoundedRectangle: View {
    
    enum Mode {
        case light, dark
            
        var associatedColor: Color {
            switch self {
            case .light: return .white.opacity(0.4)
            case .dark: return .black.opacity(0.2)
            }
        }
    }

    let mode: Mode
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(mode.associatedColor)
            .shadow(color: .black.opacity(0.3), radius: 5.0, y: 2.0)
    }
}

extension View {
    func styledBackground(mode: StyledBackgroundRoundedRectangle.Mode) -> some View {
        self.background(StyledBackgroundRoundedRectangle(mode: mode))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .padding(100)
                .styledBackground(mode: .light)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.blue, .orange], startPoint: .top, endPoint: .bottom))
    }
}
