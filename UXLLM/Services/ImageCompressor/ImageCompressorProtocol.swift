//
//  ImageCompressor.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import Foundation

protocol ImageCompressor {
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data
}
