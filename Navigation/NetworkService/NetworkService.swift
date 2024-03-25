//
//  NetworkService.swift
//  Navigation
//
//  Created by Sergey on 04.03.2024.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
    
}

final class NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        let url = URL(string: configuration.rawValue)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Код ошибки: \(httpResponse.statusCode)")
                
            } else if let httpResponse = response as? HTTPURLResponse {
//                print("HeaderFields: \(httpResponse.allHeaderFields)")
            }
            
            guard let data else {
                print("Нет данных")
                return
            }
            print("Data: \(data)")
        }
        task.resume()
    }
}

