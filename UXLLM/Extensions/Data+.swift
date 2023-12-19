//
//  Data+.swift
//  UXLLM
//
//  Created by Ali Ebrahimi Pourasad on 15.11.23.
//

import Foundation

extension Data {
    func printSizeMB() {
        let sizeInBytes = Double(self.count)
        let sizeInMegabytes = sizeInBytes / 1_024 / 1_024
        print("Datasize: " + String(format: "%.1f MB", sizeInMegabytes))
    }
    
    func printSizeKB() {
        let sizeInBytes = Double(self.count)
        let sizeInKilobytes = sizeInBytes / 1_024
        print("Datasize: " + String(format: "%.1f KB", sizeInKilobytes))
    }
    
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print("JSON:\n", JSONString)
        }
    }
}
