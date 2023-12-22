//
//  LLMCaller.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import Foundation

struct LLMCallerConfiguration {
    let modelId: String
    let base64EncodedImage: String?
    let systemContent: String
    let userContent: String
}

protocol LLMCaller {
    func call(with configuration: LLMCallerConfiguration) async throws -> String
}
