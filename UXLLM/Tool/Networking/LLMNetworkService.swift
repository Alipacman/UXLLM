//
//  LLMNetworkService.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

class LLMNetworkService {
    
    // MARK: - Properties
    static let shared = LLMNetworkService()
    private let openAIURLString = "https://api.openai.com/v1/chat/completions"
    
    enum GPTModel {
        case gpt4TurboVision, gpt35Turbo
        
        fileprivate var identifier: String {
            switch self {
            case .gpt4TurboVision: return "gpt-4-vision-preview" // $0.01 / $0.03
            case .gpt35Turbo: return "gpt-3.5-turbo-1106" // $0.0010 / $0.0020
            }
        }
        
        fileprivate var supportsVision: Bool { self == .gpt4TurboVision }
    }
    
    // MARK: - Interface
    func call(prompt: String, model: GPTModel = Constants.defaultModel,
              base64EncodedImage: String? = nil) async throws -> OpenAPIReponse {
        
        print("TestRequest called with prompt: ", prompt)
        
        var messages: [[String : Any]] = [
            ["role": "system", "content": PromptGenerator.generateSystemRole()]
        ]
        
        if let base64EncodedImage = base64EncodedImage, model.supportsVision {
            let imageContent: [String: Any] = [
                "role": "user",
                "content": [
                    ["type": "text", "text": prompt + PromptGenerator.generateAdditionalImageDescriptionToPrompt()],
                    ["type": "image_url",
                     "image_url": [
                        "url": "data:image/jpeg;base64,\(base64EncodedImage)",
                        "detail": "low",
                     ]
                    ]
                ]
            ]
            messages.append(imageContent)
        } else {
            messages.append(["role": "user", "content": prompt])
        }

        let parameters: [String : Any] = [
            "model": model.identifier,
            "messages": messages,
            "temperature": Constants.temperature,
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
    
    // MARK: - Helper
    private func header() -> [String: String]? {
    
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(LocalConfiguration.openApiKey)",
            "OpenAI-Organization": LocalConfiguration.organizationId,
        ]
        
        return header
    }
}
