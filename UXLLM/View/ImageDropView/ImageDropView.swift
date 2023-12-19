//
//  ImageDropView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import SwiftUI

struct ImageDropView: View {
    
    @StateObject var viewModel: ViewModel
    @Binding var nsImage: NSImage?
    
    var body: some View {
        content
            .frame(width: 270, height: 583) // iPhone 13 Size
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .strokeBorder(Color.white, style: StrokeStyle(lineWidth: nsImage == nil ? 4 : 0, dash: [10]))
            )
            .overlay {
                darkOverlayIfTargeted
            }
            .overlay {
                deleteButtonIfNeeded
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .onDrop(of: [.image], 
                    isTargeted: $viewModel.isTargeted,
                    perform: { providers in
                viewModel.onDrop(providers: providers)
            })
            .animation(.default, value: viewModel.isTargeted)
            .onChange(of: viewModel.compressedImage) {
                self.nsImage = viewModel.compressedImage
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
                    .foregroundColor(Color("TintColor"))
            }
        }
    }
    
    private var darkOverlayIfTargeted: some View {
        Group {
            if viewModel.isTargeted {
                ZStack {
                    Color.black.opacity(0.6)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                        Text("Image Drop View Targeted Text".localized())
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
                    viewModel.clearImage()
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
