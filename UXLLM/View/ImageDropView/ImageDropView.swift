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
            .frame(width: 240, height: 240*2.16) // iPhone 13 Size
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
    
    @ViewBuilder
    private var content: some View {
        if let nsImage {
            Image(nsImage: nsImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        } else {
            if viewModel.isLoading {
                ProgressView()
                    .colorInvert() // MacOS Workaround
                    .brightness(1)
                
            } else {
                Image(systemName: "photo.badge.plus")
                    .font(.system(size: 60))
                    .foregroundColor(Color("TintColor"))
                    .opacity(viewModel.isTargeted ? 0.0 : 1.0)
            }
        }
    }
    
    @ViewBuilder
    private var darkOverlayIfTargeted: some View {
        if viewModel.isTargeted {
            ZStack {
                Color.black.opacity(0.6)
                
                VStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                    Text("Image Drop View Targeted Text".localized())
                        .uxLLMTitleTextStyle()
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder
    private var deleteButtonIfNeeded: some View {
        if nsImage != nil {
            Button {
                viewModel.clearImage()
            } label: {
                Image(systemName: "x.circle.fill")
                    .font(.system(size: 30))
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                Circle()
                    .fill(.white)
                    .blur(radius: 3.0)
            )
            .padding()
            .topAlignWithVStack()
            .rightAlignWithHStack()
        }
    }
}

#Preview {
    let viewModel = ImageDropView.ViewModel(imageCompressor: MockedImageCompressor())
    //viewModel.isTargeted = false
    return ImageDropView(viewModel: viewModel,
                         nsImage: .constant(.init()))
        .background(InputBackgroundView())
}
