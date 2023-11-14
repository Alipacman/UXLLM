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
        let sourceCode: String?
    }
    
    static func generatePrompt(with configuration: Configuration) -> String {
        
        var base =
        """
        I have an iOS app about: \(configuration.appContext)
        The users's task is about: \(configuration.task).
        Your task is to identify 5 usability issues.
        """
        
        if let sourceCode = configuration.sourceCode, sourceCode.trimFrontAndBackWhitespaces() != "" {
            base += """
            \nFor your analysis you can also use the source code.
            \(sourceCode)
            """
        }
        
        return base
    }
    
    static func generateAdditionalImageDescriptionToPrompt() -> String {
        "\nFor your analysis you can also this screenshot of the view."
    }
    
    static func generateSystemRole() -> String {
        "You are a UI/UX expert for mobile apps."
    }
}
