//
//  AppDelegate.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - Delegate
    func applicationDidFinishLaunching(_ notification: Notification) {
        styleTitleBar()
    }

    // MARK: - Helpers
    private func styleTitleBar() {
        guard let window = NSApplication.shared.windows.first else { return }

        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.isOpaque = false

        // Hacky way to change titlebar
        let backgroundColor = NSColor(Color("BackgroundGradient1")).cgColor
        window.standardWindowButton(.closeButton)?.superview?.wantsLayer = true
        window.standardWindowButton(.closeButton)?.superview?.layer?.backgroundColor = backgroundColor
    }
}
