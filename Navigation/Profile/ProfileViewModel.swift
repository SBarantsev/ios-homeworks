//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Sergey on 06.12.2023.
//

import UIKit
import StorageService

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var model: ProfileModel
    
    var profileState: ProfileState = .loading {
        didSet {
            self.stateChanger?(profileState)
        }
    }
    
    var stateChanger: ((ProfileState) -> Void)?
    
    private let coordinator: ProfileCoordinatorProtocol
    
    init(
         coordinator: ProfileCoordinatorProtocol,
         model: ProfileModel
    ) {
        self.coordinator = coordinator
        self.model = model
    }
    
    var onNext: Action?

    func didTapPhotoCollection() {
        coordinator.pushFotos()
        profileState = .loaded
    }
}
