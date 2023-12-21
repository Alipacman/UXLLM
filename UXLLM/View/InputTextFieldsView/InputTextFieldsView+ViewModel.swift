//
//  PersistingInputTextFieldsView+ViewModel.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 21.12.23.
//

import SwiftUI

extension PersistingInputTextFieldsView {
    class ViewModel: ObservableObject {
        
        // MARK: - Properties
        internal enum TextualPersistableInput {
            case appOverview, userTask, sourceCode
            
            var userDefaultsKey: String {
                switch self {
                case .appOverview: return "appOverviewKey"
                case .userTask: return "userTaskKey"
                case .sourceCode: return "sourceCodeKey"
                }
            }
        }
        
        // MARK: - Interface
        func persist(input: TextualPersistableInput, value: String) {
            UserDefaults.standard.setValue(value, forKey: input.userDefaultsKey)
        }
        
        func load(input: TextualPersistableInput) -> String {
            UserDefaults.standard.string(forKey: input.userDefaultsKey) ?? ""
        }
    }
}
