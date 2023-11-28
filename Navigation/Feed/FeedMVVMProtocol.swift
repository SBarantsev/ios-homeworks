//
//  FeedMVVMProtocol.swift
//  Navigation
//
//  Created by Sergey on 24.11.2023.
//

import Foundation

protocol UserVMOutput {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func tapButton(_ word: String?)
}

enum State {
    case checkWord
    case wordTrue
    case wordFalse
}
