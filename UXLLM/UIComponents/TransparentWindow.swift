//
//  TransparentWindow.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

class TransparentWindowView: NSView {
  override func viewDidMoveToWindow() {
    window?.backgroundColor = .clear
    super.viewDidMoveToWindow()
  }
}

struct TransparentWindow: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return TransparentWindowView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}
