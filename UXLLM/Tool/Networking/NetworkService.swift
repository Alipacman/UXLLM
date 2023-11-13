//
//  NetworkService.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let openAIURLString = "https://api.openai.com/v1/chat/completions"
    
    func testRequest(prompt: String) async throws -> OpenAPIReponse {
        
        let messages: [[String : Any]] = [
            //["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": prompt]
        ]

        let parameters: [String : Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7,
        ]
        
        guard let url = URL(string: openAIURLString) else { throw AppError.failedAPIURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 100
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = header()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("Response: ", response)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let httpResonseError = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw AppError.httpResponse(httpResonseError)
        }
              
        let decodedResponse = try JSONDecoder().decode(OpenAPIReponse.self, from: data)
        print("Decoded Response: ", decodedResponse)
        return decodedResponse
    }
    
    // MARK: -
    private func header() -> [String: String]? {
    
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(LocalKeys.openAPIKey)",
            "OpenAI-Organization": "org-gO2dsxwUPjK1Z8AJH8GDCCtz",
        ]
        
        return header
    }
}
