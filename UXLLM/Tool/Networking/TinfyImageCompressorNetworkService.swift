//
//  CompressPNGNetworkService.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.11.23.
//

import Foundation
import Cocoa

protocol ImageCompressor {
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data
}

class TinfyImageCompressorNetworkService: ImageCompressor {
    
    // MARK: - Properties
    private let shrinkUrl = URL(string: "https://api.tinify.com/shrink")!

    // MARK: - Interface
    func resizeAndShrink(imageData: Data, size: CGSize) async throws -> Data {
        guard let jpegData = NSImage(data: imageData)?.jpegData() else {
            throw AppError.failedImageCompression
        }
        
        var shrinkRequest = URLRequest(url: shrinkUrl)
        shrinkRequest.httpMethod = "POST"
        shrinkRequest.allHTTPHeaderFields = header()
        shrinkRequest.httpBody = jpegData
        
        let (_, shrinkResponse) = try await URLSession.shared.data(for: shrinkRequest)
        guard let httpResponse = shrinkResponse as? HTTPURLResponse, httpResponse.statusCode == 201,
              let location = httpResponse.value(forHTTPHeaderField: "Location") else {
            throw AppError.failedImageCompression
        }
        
        if Constants.printNetworkData { print("Shrink Response:\n", shrinkResponse) }
        
        guard let resizeUrl = URL(string: location) else { throw AppError.failedImageCompression }
        
        var resizeRequest = URLRequest(url: resizeUrl)
        resizeRequest.httpMethod = "POST"
        resizeRequest.allHTTPHeaderFields = header()
        
        let resizeBody = ["resize": ["method": "fit",
                                     "width": size.width,
                                     "height": size.height]]
        resizeRequest.httpBody = try? JSONSerialization.data(withJSONObject: resizeBody)
        
        let (resizeData, resizeResponse) = try await URLSession.shared.data(for: resizeRequest)
        if Constants.printNetworkData { print("Resize Response:\n", resizeResponse) }
        resizeData.printSizeKB()
        return resizeData
    }
    
    // MARK: - Helper
    private func header() ->  [String: String] {
        ["Content-Type": "application/json",
         "Authorization": generateAuthHeaderValue(),
         "Accept": "application/json",
        ]
    }
    
    private func generateAuthHeaderValue() -> String {
        let auth = "api:\(LocalConfiguration.tinyPNGkey)"
        let authData = auth.data(using: String.Encoding.utf8)?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        return "Basic " + authData!
    }
}
