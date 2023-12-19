//
//  App Error.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

enum AppError: Error, LocalizedError {
    case failedAPIURL
    case httpResponse(Int)
    
    case failedImageCompression
    
    var description: String? {
        switch self {
        case .failedAPIURL: return "App Error API URL".localized()
        case .httpResponse(let code): return "App Error HTTP".localized(with: [String(code)])
        case .failedImageCompression: return "App Error Failed Image Compression".localized()
        }
    }
}
