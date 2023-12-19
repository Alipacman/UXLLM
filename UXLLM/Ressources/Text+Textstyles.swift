//
//  Text+Textstyles.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

extension View {
    func uxLLMTitleTextStyle() -> some View {
        self
            .foregroundColor(.white)
            .font(.system(size: 32, weight: .semibold))
    }

    func uxLLMBodyTextStyle() -> some View {
        self
            .foregroundColor(.white)
            .font(.system(size: 22, weight: .regular))
    }
}

