//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Sergey on 23.11.2023.
//

import UIKit

final class FeedViewModel: FeedViewModelProtocol {
   
    enum State {
        case checkWord
        case wordTrue
        case wordFalse
    }
    
    var onNext: Action?
    
    var state: State = .checkWord {
        didSet {
            print(state)
            handleState?(state)
        }
    }
    
    var handleState: ((State) -> Void)?
    
    init(handleState: ( (State) -> Void)? = nil) {
        self.handleState = handleState
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

