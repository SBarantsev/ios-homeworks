//
//  PasswordGeneration2.swift
//  Navigation
//
//  Created by Sergey on 22.08.2024.
//

import Foundation


final class PasswordGeneration2 {
    
    private var passwordSymbols: [Character] {
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        
        let letters: [Character] = (0..<58).map {
            i in
            Character(UnicodeScalar(aCode + i)!)
        }
        return letters
    }
    
    func generationPassword(quantityPassSymbols: Int) -> String {
        var newPass: String = ""
        
        for _ in 1...quantityPassSymbols {
            newPass += String(passwordSymbols.randomElement()!)
        }
        return newPass
    }
}
