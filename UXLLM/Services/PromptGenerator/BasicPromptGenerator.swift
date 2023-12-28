//
//  PromptGenerator.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct BasicPromptGenerator: PromptGenerator {
    
    func generateUserContent(with configuration: PromptConfiguration) -> String {
        var content =
        """
        I have an iOS app about: \(configuration.appOverview)
        The users's task in this app view is about: \(configuration.userTask).
        """
        
        if configuration.hasImage {
            content += """
            
            A screenshot of the app view is provided.
            """
        }
        
        if let sourceCode = configuration.sourceCode, sourceCode.trimFrontAndBackWhitespaces() != "" {
            content += """
            
            This is the swiftUI source code of the app view:
            \(sourceCode)
            """
        }
        
        return content
    }
    
    func generateSystemContent() -> String {
        return """
        You are a UI/UX expert for mobile apps. Your task is to identify \(Constants.numberOfPredictedUsabilityIssues) usability issues with the information you get for an app view.
        Enumerate the problems identified; add an empty paragraph after each enumeration; no preceding or following text."
        """
    }
}
