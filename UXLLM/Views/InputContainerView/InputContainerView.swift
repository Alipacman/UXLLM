//
//  InputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct InputContainerView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    private let sectionWidth: CGFloat = 450
    private let sectionHeigth: CGFloat = 650
    
    var body: some View {
        HStack(alignment: .top, spacing: 80) {
            Spacer()
            
            VStack {
                TitledContainerView(title: "Intro Text".localized()) { }
                Spacer(minLength: 0)
                
                TitledContainerView(title: "Image Drop Title".localized()) {
                    ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                                  nsImage: $viewModel.inputConfiguration.nsImage)
                }
                .padding(24)
                .glossyRoundedRectangleBackground(mode: .light)
            }
            .frame(width: sectionWidth, height: sectionHeigth)
            
            PersistingInputTextFieldsView(appOverview: $viewModel.inputConfiguration.appOverview,
                                          userTask: $viewModel.inputConfiguration.userTask,
                                          sourceCode: $viewModel.inputConfiguration.sourceCode)
            .padding(24)
            .glossyRoundedRectangleBackground(mode: .light)
            .frame(width: sectionWidth, height: sectionHeigth)
            
            Spacer()
        }
        .padding(40)
        .background(
            InputContainerBackgroundView()
        )
    }
}

#Preview {
    InputContainerView(viewModel: .init(imageCompressor: MockedImageCompressor()))
}
