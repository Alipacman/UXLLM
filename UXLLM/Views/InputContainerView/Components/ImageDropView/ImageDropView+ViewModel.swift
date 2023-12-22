//
//  ImageDropView+ViewModel.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import SwiftUI

extension ImageDropView {
    class ViewModel : ObservableObject {
        
        // MARK: - Properties
        @Published var isLoading: Bool = false
        @Published var isTargeted: Bool = false
        @Published var compressedImage: NSImage?
        
        internal let imageCompressor: ImageCompressor
        
        // MARK: - Init
        init(imageCompressor: ImageCompressor) {
            self.imageCompressor = imageCompressor
        }
        
        // MARK: - Interface
        func onDrop(providers: [NSItemProvider]) -> Bool {
            guard let provider = providers.first else { return false }
            _ = provider.loadDataRepresentation(for: .image) { [weak self] data, error in
                if error == nil, let data {
                    self?.received(imageData: data)
                }
            }
            return true
        }
        
        
        func clearImage() {
            compressedImage = nil
        }
        
        // MARK: - Helper
        private func received(imageData: Data) {
            setState(loadingActive: true)
            Task {
                do {
                    let compressedImageData = try await imageCompressor.resizeAndShrink(imageData: imageData,
                                                                                        size: Constants.imageCompressionSize)
                    setState(loadingActive: false, image: NSImage(data: compressedImageData))
                } catch {
                    print("Failed image compression with error: \(error.localizedDescription)")
                    setState(loadingActive: false)
                }
            }
        }
        
        private func setState(loadingActive: Bool, image: NSImage? = nil) {
            DispatchQueue.main.async {
                self.isLoading = loadingActive
                self.compressedImage = image
            }
        }
    }
}
