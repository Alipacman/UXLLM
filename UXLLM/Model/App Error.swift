//
//  App Error.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

enum AppError: Error {
    case failedAPIURL
    case httpResponse(Int)
    
    var description: String {
        switch self {
        case .failedAPIURL: return "failedAPIURL"
        case .httpResponse(let code): return "API Error: \(code)"
        }
    }
}
