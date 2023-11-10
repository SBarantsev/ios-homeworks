//
//  User.swift
//  Navigation
//
//  Created by Sergey on 02.11.2023.
//

import UIKit

struct User {
    var login: String
    var userName: String
    var avatar: UIImage?
    var status: String
}

extension User {
    static func make() -> [User] {
        [
            User(login: "giraffe",
                 userName: "Happy Giraffe",
                 avatar: UIImage(named:"Avatar"),
                 status: "Let's go play basketball"),
            User(login: "dog",
                 userName: "Big Doggy Boss",
                 avatar: UIImage(named:"photo_9"),
                 status: "Where's my chappy??"),
            User(login: "cat",
                 userName: "Lion",
                 avatar: UIImage(named:"photo_11"),
                 status: "Let's go to the party")
        ]
    }
}

protocol UserService {
    func checkUser (login: String) -> User?
}

final class CurrenUserService: UserService {
    
    var users = User.make()
    
    func checkUser(login: String) -> User? {
        
        for user in users {
            if user.login == login {
                return user
            }
        }
        return nil
    }
}

final class TestUserService: UserService {
    
    let user = User(
        login: "user",
        userName: "Test User",
        avatar: UIImage(named: "LogoVK")!,
        status: "Hello world"
    )
    
    func checkUser(login: String) -> User? {
        let user = user
        
        if login == user.login {
            return user
        } else {return nil}
    }
}

