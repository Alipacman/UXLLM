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
        let usesImage: Bool
    }
    
    static func generatePrompt(with configuration: Configuration) -> String {
        
        var base =
        """
        I have an iOS app about: \(configuration.appContext)
        The users's task in this app view is about: \(configuration.task).
        """
        
        if configuration.usesImage {
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
    
    // MARK: -
    static let usabilityAttributes = [
        "efficiency",       // 70%
        "satisfaction",     // 66%
        "effectiveness",    // 58%
        "learnability",     // 46%
        "memorability",     // 23%
        "cognitive load",   // 19%
        "errors",           // 17%
        "operability",      // 8%
        "accessibility",    // 4%
        "flexibility",      // 0%
        "acceptability",    // 0%
        "simplicity",
        "ease of use",
    ].joined(separator: ",")
    
    static let numberOfIssues: Int = 10
    
    static func generateSystemRole() -> String {
        return """
        
        You are a UI/UX expert for mobile apps. Your task is to identify \(numberOfIssues) usability issues with the information you get for an app view.
        For your answer only list the identified issues
        """
    }
}


/*
 ------------------- Basic
 return """
 
 You are a UI/UX expert for mobile apps. Your task is to identify \(numberOfIssues) usability issues with the information you get for an app view.
 For your answer only list the identified issues
 """

------------------- Usability Def. + Usability Problem Def.
 return """
 
 You are a UI/UX expert for mobile apps. Your task is to identify \(numberOfIssues) usability problems with the information you get for an app view.
 Usability is defined by ISO 9241-11: "Extent to which a product can be used by specified users to achieve specified goals with effectiveness, efficiency and satisfaction in a specified context of use."
 A usability problem is defined as "an aspect of the system and/or a demand on the user which makes it unpleasant, inefficient, onerous or impossible for the user to achieve their goals in typical usage situations."
 For your answer only list the identified issues
 """
 
 ------------------- Usability Def + Usability problem definition + Attributes
 return """
 
 You are a UI/UX expert for mobile apps. Your task is to identify \(numberOfIssues) usability problems with the information you get for an app view.
 Usability is defined by ISO 9241-11: "Extent to which a product can be used by specified users to achieve specified goals with effectiveness, efficiency and satisfaction in a specified context of use."
 A usability problem is defined as "an aspect of the system and/or a demand on the user which makes it unpleasant, inefficient, onerous or impossible for the user to achieve their goals in typical usage situations."
 Match identified issues to one or more of the following attributes:
 [\(usabilityAttributes)]
 For your answer only list the identified issues
 """

 */
