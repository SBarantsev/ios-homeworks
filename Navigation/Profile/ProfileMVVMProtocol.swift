//
//  ProfileMVVMProtocol.swift
//  Navigation
//
//  Created by Sergey on 06.12.2023.
//

import UIKit
import StorageService

protocol ProfileViewModelProtocol {
    
    var model: ProfileModel { get set }
    
    var profileState: ProfileState { get set }
    
    var stateChanger: ((ProfileState) -> Void)? {get set}
    
    var onNext: Action? { get set }

    func didTapPhotoCollection()
}

enum ProfileState {
    case loading
    case loaded
}

