//
//  MockedLLMCaller.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import Foundation

import Foundation

public struct MockedLLMCaller: LLMCaller {
    
    public var mockedResultText: String
    
    // MARK: - Init
    public init(mockedResultText: String) {
        self.mockedResultText = mockedResultText
    }
    
    // MARK: - Interface
    public func call(with configuration: LLMCallerConfiguration) async throws -> String {
        try await Task.sleep(until: .now + .seconds(4), clock: .continuous)
        return mockedResultText
    }
}
