//
//  CompressPNGNetworkService.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.11.23.
//

import Foundation
import AppKit

class CompressPNGNetworkService {
    
    // MARK: -
    static let shared = CompressPNGNetworkService()
    
    private let shrinkUrl = URL(string: "https://api.tinify.com/shrink")!

    // MARK: -
    func resizeAndCompress(image: NSImage, size: CGSize = Constants.sizeToResizeTo) async -> Data? {
        guard let jpegData = image.jpegData() else {
            return nil
        }

        var shrinkRequest = URLRequest(url: shrinkUrl)
        shrinkRequest.httpMethod = "POST"
        shrinkRequest.allHTTPHeaderFields = header()
        shrinkRequest.httpBody = jpegData

        do {
            let (_, shrinkResponse) = try await URLSession.shared.data(for: shrinkRequest)
            guard let httpResponse = shrinkResponse as? HTTPURLResponse, httpResponse.statusCode == 201,
                  let location = httpResponse.value(forHTTPHeaderField: "Location") else {
                return nil
            }
            
            if Constants.printNetworkData { print("Shrink Response:\n", shrinkResponse) }

            guard let resizeUrl = URL(string: location) else { return nil }
            
            var resizeRequest = URLRequest(url: resizeUrl)
            resizeRequest.httpMethod = "POST"
            resizeRequest.allHTTPHeaderFields = header()
            
            let resizeBody = ["resize": ["method": "fit",
                                         "width": size.width,
                                         "height": size.height]]
            resizeRequest.httpBody = try? JSONSerialization.data(withJSONObject: resizeBody)

            let (resizeData, resizteResponse) = try await URLSession.shared.data(for: resizeRequest)
            if Constants.printNetworkData { print("Resize Response:\n", resizteResponse, resizeData) }
            resizeData.printSizeKB()
            return resizeData
        } catch {
            print("TinyPNGNetworkService Error: \(error)")
        }

        return nil
    }
    
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

import Cocoa

extension NSImage {
    func jpegData() -> Data? {
        let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        return jpegData
    }
}
