//
//  ProfileModel.swift
//  Navigation
//
//  Created by Sergey on 06.12.2023.
//

import UIKit
import StorageService


final class ProfileModel {

    let data = Post.make()
    
    let user: User

    init(user: User) {
        self.user = user
    }

}
