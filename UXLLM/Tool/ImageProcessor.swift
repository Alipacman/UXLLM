//
//  ImageProcessor.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation
import SwiftUI

// TODO: -
struct ImageProcessor {
    static func resizeImage(nsImage: NSImage?, 
                            toByteLimit targetSizeInBytes: Int = Constants.byteLimit) -> NSImage? {
        guard let nsImage = nsImage else { return nil }

        var compressionFactor: CGFloat = 1.0
        var resizedImage: NSImage?

        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)

        while compressionFactor > 0 {
            guard let imageData = bitmapRep.representation(using: .jpeg, properties: [.compressionFactor: compressionFactor]) else {
                break
            }
            
            if imageData.count <= targetSizeInBytes {
                resizedImage = NSImage(data: imageData)
                break
            }
            
            compressionFactor -= 0.05
            
            print("ImageConverter Current Size: \(imageData.count)")
        }

        return resizedImage
    }

    static func convertToBase64(nsImage: NSImage?) -> String? {
        guard let nsImage = nsImage else { return nil }

        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        guard let imageData = bitmapRep.representation(using: .jpeg, properties: [:]) else {
            return nil
        }

        return imageData.base64EncodedString()
    }
}
