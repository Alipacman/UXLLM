//
//  MockedImageCompressor.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import Foundation

struct MockedImageCompressor: ImageCompressor {
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data {
        try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
        return imageData
    }
}
