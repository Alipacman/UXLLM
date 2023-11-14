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
        Identify 5 usability issues for a component about \(configuration.task).
        """
        
        if let sourceCode = configuration.sourceCode, sourceCode.trimFrontAndBackWhitespaces() != "" {
            base += """
            Here is the source code:
            \(sourceCode)
            """
        }
        
        return base
    }
    
    static func generateAdditionalImageDescriptionToPrompt() -> String {
        "Here is a screenshot of the view."
    }
    
    static func generateSystemRole() -> String {
        "You are a UI/UX expert for mobile apps."
    }
}
