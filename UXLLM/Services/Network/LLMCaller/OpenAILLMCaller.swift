//
//  LLMNetworkService.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

class OpenAILLMCaller: LLMCaller {
    
    // MARK: - Properties
    private let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    // MARK: - Interface
    func call(with configuration: LLMCallerConfiguration) async throws -> String {
        let messages = prepareMessages(configuration: configuration)
        let parameters = prepareParameters(messages: messages, configuration: configuration)
        let urlRequest = try createURLRequest(with: parameters)
        
        let (data, response) = try await performNetworkRequest(urlRequest)
        return try processResponse(data, response)
    }
    
    // MARK: - Helper Methods
    private func prepareMessages(configuration: LLMCallerConfiguration) -> [[String: Any]] {
        var messages: [[String : Any]] = [["role": "system", "content": configuration.systemContent]]
        let imageContentIfAvailable = generateImageContentIfNeeded(configuration: configuration)
        let basicUserContent = ["role": "user", "content": configuration.userContent]
        messages.append(imageContentIfAvailable ?? basicUserContent)
        return messages
    }
    
    private func prepareParameters(messages: [[String: Any]], configuration: LLMCallerConfiguration) -> [String: Any] {
        [
            "model": configuration.modelId,
            "messages": messages,
        ]
    }
    
    private func createURLRequest(with parameters: [String: Any]) throws -> URLRequest {
        var urlRequest = URLRequest(url: openAIURL)
        urlRequest.timeoutInterval = 100
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = header()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        return urlRequest
    }
    
    private func performNetworkRequest(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        data.printJSON()
        return (data, response)
    }
    
    private func processResponse(_ data: Data, _ response: URLResponse) throws -> String {
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let httpResponseErrorCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "OpenAILLMCaller", code: httpResponseErrorCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(OpenAPIResponse.self, from: data)
        // Can be engeneered to return proper model in the future
        return decodedResponse.prettyResponse
    }
    
    private func generateImageContentIfNeeded(configuration: LLMCallerConfiguration) -> [String: Any]? {
        guard let base64EncodedImage = configuration.base64EncodedImage else { return nil }
        return ["role": "user",
                "content": [
                    ["type": "text",
                     "text": configuration.userContent],
                    ["type": "image_url",
                     "image_url": [
                        "url": "data:image/jpeg;base64,\(base64EncodedImage)",
                        "detail": "low",
                     ]
                    ]
                ]
        ]
    }
    
    private func header() -> [String: String]? {
        ["Content-Type": "application/json",
         "Authorization": "Bearer \(LocalConfiguration.openAIKey)"]
    }
}

private extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print("JSON:\n", JSONString)
        }
    }
}
