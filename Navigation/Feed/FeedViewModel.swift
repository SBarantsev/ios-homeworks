//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Sergey on 23.11.2023.
//

import UIKit

final class FeedViewModel: UserVMOutput {
    
    var state: State = .checkWord {
        didSet {
            print(state)
            currentState?(state)
        }
    }
    
    var currentState: ((State) -> Void)?
    
    init(currentState: ( (State) -> Void)? = nil) {
        self.currentState = currentState
    }
    
    func tapButton(_ word: String?) {
        
        guard let checkWord = word else {return}
        let userSecretWord = FeedModel()
        if checkWord == userSecretWord.secretWord {
            return self.state = .wordTrue
        } else {
            self.state = .wordFalse
        }
    }
}
