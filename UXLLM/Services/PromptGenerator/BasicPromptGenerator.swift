//
//  PromptGenerator.swift
//  UXLLM under the MIT License (MIT)
//  Copyright (c) 2023 MaibornWolff GmbH All rights reserved.
//
//  Created by Ali Ebrahimi Pourasad on 13.11.23.
//

import Foundation

struct BasicPromptGenerator: PromptGenerator {
    
    // MARK: - User Content
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
        
        if let sourceCode = configuration.sourceCode, 
            !sourceCode.trimFrontAndBackWhitespaces().isEmpty {
            content += """
            
            Below is the incomplete SwiftUI code of the app view. The code includes the view's code for the user interface, the view model for logic handling, and potentially additional components such as model or preview code.
            \(sourceCode)
            """
        }
        
        return content
    }
    
    // MARK: - System Content
    func generateSystemContent() -> String {
        return """
        You are a UI/UX expert for mobile apps.
        Your task is to identify usability issues with the information you get for an app view. 
        An example of a usability issue could be: "Lack of visual feedback on user interactions".
        Respond using app domain language, you are MUSST NOT use technical terminology or mention code details.
        Enumerate the problems identified; add an empty paragraph after each enumeration; no preceding or following text.
        """
    }
}
