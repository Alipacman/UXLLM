//
//  ModelChoosingView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.11.23.
//

import SwiftUI

struct ModelChoosingView: View {
    @Binding var selectedModel: LLMNetworkService.GPTModel

    var body: some View {
        Picker("", selection: $selectedModel) {
            Text("GPT-3.5 Turbo").tag(LLMNetworkService.GPTModel.gpt35Turbo)
            Text("GPT-4 Turbo").tag(LLMNetworkService.GPTModel.gpt4Turbo)
            Text("GPT-4 Turbo Vision").tag(LLMNetworkService.GPTModel.gpt4TurboVision)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
