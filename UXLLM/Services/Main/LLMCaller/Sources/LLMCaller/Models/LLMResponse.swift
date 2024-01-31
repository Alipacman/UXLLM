//
//  LLMResponse.swift
//  
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 17.01.24.
//

import Foundation

// Can be engineered to return more in the future
public struct LLMResponse {
    public let text: String
    public let tokens: Int
}
