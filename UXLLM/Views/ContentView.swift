//
//  ContentView.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = ""
    @State var response: String = "NA"
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text(response)
                
                TextField("Heyy", text: $text)
                
                Button {
                    
                    Task {
                        do {
                            let xxx = try await NetworkService.shared.testRequest(prompt: text)
                            self.response = xxx.choices.first?.message.content ?? "Failed Parse"
                        } catch {
                            self.response = error.localizedDescription
                        }
                    }
                    
                } label: {
                    Text("Start")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
