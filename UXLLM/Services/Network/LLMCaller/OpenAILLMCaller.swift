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
        
        var messages: [[String : Any]] = [
            ["role": "system", "content": configuration.systemContent]
        ]
        
        if let imageContent = generateImageContentIfNeeded(configuration: configuration) {
            messages.append(imageContent)
        } else {
            messages.append(["role": "user", "content": configuration.userContent])
        }

        var parameters: [String : Any] = [
            "model": configuration.modelId,
            "messages": messages,
            "temperature": Constants.temperature,
        ]
        
        if let maxTokens = Constants.maxTokens {
            parameters["max_tokens"] = maxTokens
        }
        
        let urlRequest = try urlRequest(parameters: parameters)
        
        if Constants.printNetworkData { print("Request header: ", urlRequest.allHTTPHeaderFields ?? "NA",
                                              "\n\nRequest Parameters: ", parameters) }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if Constants.printNetworkData { print("Response: ", response); data.printJSON() }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let httpResponseErrorCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw AppError.httpResponse(httpResponseErrorCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(OpenAPIResponse.self, from: data)
        return decodedResponse.prettyResponse
    }
    
    // MARK: - Helper
    private func generateImageContentIfNeeded(configuration: LLMCallerConfiguration) -> [String: Any]? {
        guard let base64EncodedImage = configuration.base64EncodedImage else { return nil }
        return ["role": "user",
                "content": [
                    ["type": "text",
                     "text": configuration.userContent],
                    ["type": "image_url",
                     "image_url": [
                        "url": "data:image/jpeg;base64,\(base64EncodedImage)",
                        "detail": Constants.imageDetail,
                     ]
                    ]
                ]
        ]
    }
    
    private func header() -> [String: String]? {
        ["Content-Type": "application/json",
         "Authorization": "Bearer \(LocalConfiguration.openAIKey)"]
    }
    
    private func urlRequest(parameters: [String : Any]) throws -> URLRequest {
        var urlRequest = URLRequest(url: openAIURL)
        urlRequest.timeoutInterval = 100
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = header()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        return urlRequest
    }
}
