//
//  MockedImageCompressor.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import Foundation

struct MockedImageCompressorService: ImageCompressor {
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data {
        try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
        return imageData
    }
}
