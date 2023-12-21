//
//  ImageDropView+ViewModel.swift
//  UXLLM
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
        
        let imageCompressor: ImageCompressor
        
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
            self.compressedImage = nil
        }
        
        // MARK: - Helper
        private func received(imageData: Data) {
            clearImage()
            setLoading(active: true)
            Task {
                do {
                    let compressedImageData = try await imageCompressor.resizeAndShrink(imageData: imageData, size: Constants.imageCompressionSize)
                    DispatchQueue.main.async {
                        self.compressedImage = NSImage(data: compressedImageData)
                        self.setLoading(active: false)
                    }
                } catch {
                    print("Failed image compression with error: \(error.localizedDescription)")
                    self.setLoading(active: false)
                }
            }
        }
        
        private func setLoading(active: Bool) {
            DispatchQueue.main.async {
                self.isLoading = active
            }
        }
    }
}
