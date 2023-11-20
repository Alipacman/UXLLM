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
            
            
            For your analysis you can use the provided screenshot.
            """
        }
        
        if let sourceCode = configuration.sourceCode, sourceCode.trimFrontAndBackWhitespaces() != "" {
            base += """
            
            
            For your analysis you can use the source code:
            \(sourceCode)
            """
        }
        
        return base
    }
    
    enum UsabilityMetric: String {
        case iso9241 = "ISO 9241"
        case iso25010 = "ISO 25010"
        case iso91261 = "ISO 9126"
        case ieeeGlossary = "IEEE Glossary"
        case Nielsen = "Nielsen"
        case bevan = "Bevan"

    }
    
    static func generateSystemRole() -> String {
        let usabilityMetricToUse: String = UsabilityMetric.bevan.rawValue
        
        return "You are a UI/UX expert for mobile apps. Your task is to identify 5 \(usabilityMetricToUse) usability issues with the information you get for an app view. For your answer only list the identfied issues with the associated \(usabilityMetricToUse) violation."
    }
    
    static func generateSystemRoleWithAttributeList() -> String {
        let usabilityAttributes = ["efficiency", "satisfaction", "effectiveness", "learnability", "memorability", "cognitive load, errors", "simplicity", "ease of use, navigation", "operability", "usefulness", "attractiveness", "comprehensibility", "aesthetics", "accessibility", "accuracy", "adaptability", "consistency", "interaction", "learning performance", "training", "understandability", "user error protection"]
        
        return "You are a UI/UX expert for mobile apps. Your task is to identify 5 usability issues with the information you get for an app view. For your answer only list the identfied issues with the associated violation from this list of usability attributes: \(usabilityAttributes)."
    }
}
