//
//  ExtensionString.swift
//  Navigation
//
//  Created by Sergey on 17.09.2024.
//

import Foundation

extension String {
    var localize: String {
        NSLocalizedString(self, comment: "")
    }
}
