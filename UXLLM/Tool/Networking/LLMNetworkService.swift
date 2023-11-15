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
    
    enum GPTModel: Identifiable {
        case gpt4Turbo, gpt4TurboVision, gpt35Turbo
        
        var id: String { self.identifier }
        
        fileprivate var identifier: String {
            switch self {
            case .gpt4Turbo: return "gpt-4-1106-preview"
            case .gpt4TurboVision: return "gpt-4-vision-preview" // $0.01 Input / $0.03 Output per 1k tokens
            case .gpt35Turbo: return "gpt-3.5-turbo-1106" // $0.0010 / $0.0020 per 1k tokens
            }
        }
        
        var supportsVision: Bool { self == .gpt4TurboVision }
        fileprivate var needsVisionCodable: Bool { self == .gpt4TurboVision }
        
        fileprivate var inputOutputTokenPricePer1kTokens: (CGFloat, CGFloat) {
            switch self {
            case .gpt4TurboVision, .gpt4Turbo: return (0.01, 0.03) // $0.01, $0.03
            case .gpt35Turbo: return (0.0010, 0.0020) // $0.0010 / $0.0020
            }
        }
    }
    
    // MARK: - Interface
    func call(prompt: String, model: GPTModel, base64EncodedImage: String? = nil) async throws -> String {
        print("TestRequest called with prompt: ", prompt, "And image with count: \(String(describing: base64EncodedImage?.count))")
        
        if model.supportsVision {
            guard base64EncodedImage != nil else { return "Image Missing" }
        }
        
        var messages: [[String : Any]] = [
            ["role": "system", "content": PromptGenerator.generateSystemRole()]
        ]
        
        if let base64EncodedImage = base64EncodedImage, model.supportsVision {
            let imageContent: [String: Any] = [
                "role": "user",
                "content": [
                    ["type": "text",
                     "text": prompt],
                    ["type": "image_url",
                     "image_url": [
                        "url": "data:image/jpeg;base64,\(base64EncodedImage)",
                        "detail": Constants.imageDetail,
                     ]
                    ]
                ]
            ]
            messages.append(imageContent)
        } else {
            messages.append(["role": "user", "content": prompt])
        }

        var parameters: [String : Any] = [
            "model": model.identifier,
            "messages": messages,
            "temperature": Constants.temperature,
        ]
        
        if let maxTokens = Constants.maxTokens {
            parameters["max_tokens"] = maxTokens
        }
        
        if Constants.printNetworkData { print("Request Parameters: ", parameters) }
        
        guard let url = URL(string: openAIURLString) else { throw AppError.failedAPIURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 100
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = header()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        if Constants.printNetworkData { print("Request header: ", urlRequest.allHTTPHeaderFields ?? "NA") }
        //print("Request body: ", parameters)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if Constants.printNetworkData { print("Response: ", response); data.printJSON() }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let httpResonseError = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw AppError.httpResponse(httpResonseError)
        }
    
        if model.needsVisionCodable {
            let decodedResponse = try JSONDecoder().decode(OpenAPIResponseVision.self, from: data)
            print("Decoded Response: ", decodedResponse)
            print(decodedResponse.calculatePrice(inputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.0,
                                                 outputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.1))
            return decodedResponse.prettyResponse
        } else {
            let decodedResponse = try JSONDecoder().decode(OpenAPIResponseNormal.self, from: data)
            print("Decoded Response: ", decodedResponse)
            print(decodedResponse.calculatePrice(inputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.0,
                                                 outputTokenPricePer1k: model.inputOutputTokenPricePer1kTokens.1))
            return decodedResponse.prettyResponse
        }
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
