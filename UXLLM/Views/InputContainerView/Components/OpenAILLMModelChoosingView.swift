//
//  ModelChoosingView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.11.23.
//

import SwiftUI

struct OpenAILLMModelChoosingView: View {
    @Binding var selectedModel: OpenAILLM

    var body: some View {
        Picker("", selection: $selectedModel) {
            ForEach(OpenAILLM.allCases) { model in
                Text(model.presentationName).tag(model)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
