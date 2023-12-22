//
//  Text+Textstyles.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 19.12.23.
//

import SwiftUI

extension View {
    func uxLLMTitleTextStyle() -> some View {
        self
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 22, weight: .semibold))
    }

    func uxLLMBodyTextStyle() -> some View {
        self
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 14, weight: .regular))
    }
    
    func uxLLMButtonTitleTextStyle() -> some View {
        self
            .foregroundColor(Color("TintColor"))
            .font(.system(size: 18, weight: .semibold))
    }
}

