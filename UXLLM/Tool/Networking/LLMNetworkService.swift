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
            case .gpt4TurboVision: return "gpt-4-vision-preview" // $0.01 Input / $0.03 Output per 1k tokens
            case .gpt35Turbo: return "gpt-3.5-turbo-1106" // $0.0010 / $0.0020 per 1k tokens
            }
        }
        
        fileprivate var supportsVision: Bool { self == .gpt4TurboVision }
        
        fileprivate var inputOutputTokenPricePer1kTokens: (CGFloat, CGFloat) {
            switch self {
            case .gpt4TurboVision: return (0.01, 0.03) // $0.01, $0.03
            case .gpt35Turbo: return (0.0010, 0.0020) // $0.0010 / $0.0020
            }
        }
    }
    
    // MARK: - Interface
    func call(prompt: String, model: GPTModel = Constants.defaultModel,
              base64EncodedImage: String? = nil) async throws -> OpenAPIResponse {
        
        print("TestRequest called with prompt: ", prompt, "And image with count: \(String(describing: base64EncodedImage?.count))")
        
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
            "max_tokens": Constants.maxTokens,
        ]
        
        guard let url = URL(string: openAIURLString) else { throw AppError.failedAPIURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 100
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = header()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        print("Request header: ", urlRequest.allHTTPHeaderFields ?? "NA")
        //print("Request body: ", parameters)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("Response: ", response)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let httpResonseError = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw AppError.httpResponse(httpResonseError)
        }
              
        let decodedResponse = try JSONDecoder().decode(OpenAPIResponse.self, from: data)
        print("Decoded Response: ", decodedResponse)
        print(decodedResponse.calculatePrice(inputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.0,
                                             outputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.1))
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
