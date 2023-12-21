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
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 28, weight: .semibold))
    }
    
    func uxLLMButtonTitleTextStyle() -> some View {
        self
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 22, weight: .regular))
    }

    func uxLLMBodyTextStyle() -> some View {
        self
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 18, weight: .regular))
    }
}

