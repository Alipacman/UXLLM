//
//  UXLLMApp.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct VisualEffect: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}

@main
struct UXLLMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(llmCaller: OpenAILLMCaller(),
                                         promptGenerator: BasicPromptGenerator(),
                                         imageCompressor: TinfyImageCompressorNetworkService()))
            .background(VisualEffect().ignoresSafeArea())
        }
    }
}
