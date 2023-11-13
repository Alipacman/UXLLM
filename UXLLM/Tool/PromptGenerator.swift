//
//  PromptGenerator.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct PromptGenerator {
    struct Configuration {
        let appContext: String
        let task: String
        let sourceCode: String
    }
    
    static func generatePrompt(with configuration: Configuration) -> String {
        """
        I have an iOS app about: \(configuration.appContext)
        Identify 5 usability issues for a component about \(configuration.task).
        Here is the source code:
        \(configuration.sourceCode)
        """
    }
}
