//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Sergey on 23.11.2023.
//

import UIKit

final class FeedViewModel: FeedViewModelProtocol {
   
    private let coordinator: FeedCoordinatorProtocol
    
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
    
    init(handleState: ( (State) -> Void)? = nil, coordinator: FeedCoordinatorProtocol) {
        self.handleState = handleState
        self.coordinator = coordinator
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

extension FeedViewModel: FeedCoordinatorProtocol {
    func pushInfoViewController() {
        coordinator.pushInfoViewController()
    }
}
