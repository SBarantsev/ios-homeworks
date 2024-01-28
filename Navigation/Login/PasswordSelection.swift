//
//  PasswordSelection.swift
//  Navigation
//
//  Created by Sergey on 21.01.2024.
//

import Foundation

final class PasswordSelection {
    
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
    
    func brutForce(pass: String) -> String {
        
        var correctPass = ""
        var changePass = 0
        
        for symb1 in passwordSymbols {
            let checkingPass1 = String(symb1)
            for symb2 in passwordSymbols {
                let checkingPass2 = checkingPass1 + String(symb2)
                
                for symb3 in passwordSymbols {
                    let checkingPass3 = checkingPass2 + String(symb3)
                    
                    for symb4 in passwordSymbols {
                        let checkingPass4 = checkingPass3 + String(symb4)
                        
                        for symb5 in passwordSymbols {
                            let checkingPass5 = checkingPass4 + String(symb5)
                            if checkingPass5 == pass {
                                correctPass = checkingPass5
                                break
                            } else {
                                changePass += 1
                            }
                        }
                    }
                }
            }
        }
        print("Проверено комбинаций:", changePass)
        return correctPass
    }
}
