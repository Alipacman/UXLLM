//
//  MockedLLMCaller.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 18.12.23.
//

import Foundation

import Foundation

struct MockedLLMCaller: LLMCaller {
    
    static let mockedUsabilityIssues = 
"""
Mocked Usability Issues:
1. Font too small, making text hard to read.
2. Inconsistent color scheme leading to poor visual hierarchy.
3. Non-responsive layout, causing issues on different screen sizes.
4. Complicated navigation that confuses users.
5. Lack of accessibility options, such as screen reader support.
6. Slow loading times affecting user experience.
7. Overloaded interfaces with too many elements on one screen.
8. Unclear error messages that don't guide users to a solution.
9. Inadequate feedback on user actions (e.g., no confirmation after submitting a form).
10. Poor touch target sizes on mobile, making buttons hard to tap.
"""
    
    func call(with configuration: LLMCallerConfiguration) async throws -> String {
        try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
        return Self.mockedUsabilityIssues
    }
}
