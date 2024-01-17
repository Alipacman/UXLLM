//
//  UXLLMApp.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

@main
struct UXLLMApp: App {
    
    // MARK: - Properties
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewViewModelFactory.generateConfiguredContentViewViewModel())
                .background(TransparentWindow())
                .preferredColorScheme(.dark)
        }
    }
}
