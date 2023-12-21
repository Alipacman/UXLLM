//
//  ImageCompressor.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import Foundation

protocol ImageCompressor {
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data
}
