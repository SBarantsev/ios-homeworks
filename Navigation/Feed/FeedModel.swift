//
//  FeedModel.swift
//  Navigation
//
//  Created by Sergey on 16.11.2023.
//

import UIKit

final class FeedModel {
    
    let secretWord = "secret"
    
    func check(word: String) -> Bool {
        if word == secretWord {return true}
        else {return false}
    }
}
