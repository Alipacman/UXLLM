//
//  App Error.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

enum AppError: Error, LocalizedError {
    case httpResponse(Int)

    case failedConvertingImageData
    case failedExtractingResizeURL
    
    var description: String? {
        switch self {
        case .httpResponse(let code): return "App Error HTTP".localized(with: [String(code)])
        case .failedConvertingImageData: return "App Error Failed Converting ImageData".localized()
        case .failedExtractingResizeURL: return "App Error Failed Image Resize URL".localized()
        }
    }
}
