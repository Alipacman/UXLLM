//
//  ImageDropArea.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct ImageDropArea: View {
    
    @State private var isTargeted: Bool = false
    @Binding var nsImage: NSImage?

    var body: some View {
        content
            .frame(width: 400, height: 600)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .strokeBorder(style: StrokeStyle(lineWidth: nsImage == nil ? 4 : 0,
                                                     dash: [10]))
            )
            .overlay {
                darkOverlayIfTargeted
            }
            .overlay {
                deleteButtonIfNeeded
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .onDrop(of: [.image], isTargeted: $isTargeted, perform: { providers in
                guard let provider = providers.first else { return false }

                _ = provider.loadDataRepresentation(for: .image) { data, error in
                    if error == nil, let data {
                        received(data: data)
                    }
                }
                return true
            })
            .animation(.default, value: isTargeted)
    }
    
    private func received(data: Data) {
        Task {
            guard let nsImage = NSImage(data: data) else { return }
            guard let compressedImageData = await TinyPNGNetworkService.shared.resizeAndCompress(image: nsImage)
            else {
                print("Failed compressedImageData")
                return
            }
            self.nsImage = NSImage(data: compressedImageData)
        }
    }

    private var content: some View {
        Group {
            if let nsImage {
                Image(nsImage: nsImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            } else {
                Image(systemName: "photo.badge.plus")
                    .font(.system(size: 60))
                    .foregroundColor(.black)
            }
        }
    }
    
    private var darkOverlayIfTargeted: some View {
        Group {
            if isTargeted {
                ZStack {
                    Color.black.opacity(0.6)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                        Text("Drop your view preview here...")
                    }
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                }
            }
        }
    }
    
    private var deleteButtonIfNeeded: some View {
        Group {
            if nsImage != nil {
                Button {
                    self.nsImage = nil
                } label: {
                    Image(systemName: "x.circle.fill")
                        .font(.system(size: 30))
                }
                .frame(width: 30, height: 30)
                .padding()
                .topAlignWithVStack()
                .rightAlignWithHStack()
            }
        }
    }
}
