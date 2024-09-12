//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Sergey on 09.12.2023.
//

import UIKit

typealias Action = (() -> Void)

protocol CoordinatorProtocol: AnyObject {
    
    func start() -> UIViewController
}
