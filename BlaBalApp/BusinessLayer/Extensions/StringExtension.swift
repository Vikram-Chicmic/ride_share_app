//
//  StringExtension.swift
//  BlaBalApp
//
//  Created by ChicMic on 30/06/23.
//

import Foundation
extension String {
    /// extension to validate name 
    var containsSpecialCharacters: Bool {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=~`|\\{[]}:;\"'<>,.?/")
        return rangeOfCharacter(from: specialCharacterSet) != nil
    }
    
    var containsNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var containsWhitespace: Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
}
