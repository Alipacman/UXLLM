//
//  PromptGenerator.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct BasicPromptGenerator: PromptGenerator {
    func generateUserContent(with configuration: PromptConfiguration) -> String {
        
        var base =
        """
        I have an iOS app about: \(configuration.appOverview)
        The users's task in this app view is about: \(configuration.userTask).
        """
        
        if configuration.hasImage {
            base += """
            
            A screenshot of the app view is provided.
            """
        }
        
        if let sourceCode = configuration.sourceCode, sourceCode.trimFrontAndBackWhitespaces() != "" {
            base += """
            
            This is the swiftUI source code of the app view:
            \(sourceCode)
            """
        }
        
        return base
    }
    
    func generateSystemContent() -> String {
        return """
        You are a UI/UX expert for mobile apps. Your task is to identify \(Constants.numberOfPredictedUsabilityIssues) usability issues with the information you get for an app view.
        For your answer only list the identified issues
        """
    }
}
