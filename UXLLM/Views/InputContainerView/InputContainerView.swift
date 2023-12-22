//
//  InputContainerView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

struct InputContainerView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ViewModel
    
    private let sectionWidth: CGFloat = 450
    private let sectionHeigth: CGFloat = 600
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 80) {
            Spacer()
            
            titleAndImageDropSection
            
            textFieldSection
            
            Spacer()
        }
        .padding(40)
        .background(
            InputContainerBackgroundView()
        )
    }
    
    private var titleAndImageDropSection: some View {
        VStack {
            TitledContainerView(title: "Intro Text".localized()) { }
            Spacer()
            TitledContainerView(title: "Image Drop Title".localized(), accessoryQuestionMark: true) {
                ImageDropView(viewModel: .init(imageCompressor: viewModel.imageCompressor),
                              nsImage: $viewModel.inputConfiguration.nsImage)
            }
            .padding(24)
            .glossyRoundedRectangleBackground(mode: .light)
        }
        .frame(width: sectionWidth, height: sectionHeigth)
    }
    
    private var textFieldSection: some View {
        PersistingInputTextFieldsView(appOverview: $viewModel.inputConfiguration.appOverview,
                                      userTask: $viewModel.inputConfiguration.userTask,
                                      sourceCode: $viewModel.inputConfiguration.sourceCode)
        .padding(24)
        .glossyRoundedRectangleBackground(mode: .light)
        .frame(width: sectionWidth, height: sectionHeigth)
    }
}

// MARK: - Preview
#Preview {
    InputContainerView(viewModel: .init(imageCompressor: MockedImageCompressor()))
}
