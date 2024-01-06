//
//  FeedViewModelProtocol.swift
//  Navigation
//
//  Created by Sergey on 24.11.2023.
//

import UIKit

protocol FeedViewModelProtocol {
    
    var handleState: ((FeedViewModel.State) -> Void)? { get set }
    func tapButton(_ word: String?)
}
