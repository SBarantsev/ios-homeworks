//
//  NetworkService2.swift
//  Navigation
//
//  Created by Sergey on 17.03.2024.
//


import Foundation

final class NetworkService2 {
    
    func getRequest(completion: @escaping (_ title: String) -> Void) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        do {
                            guard let json = try
                                    JSONSerialization.jsonObject(with: data) as?
                                    [String: Any] else {
                                assertionFailure()
                                return
                            }
                            completion(json["title"] as! String)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                default:
                    print("data error")
                }
            }
        }
        dataTask.resume()
    }
    
    func getRequestOrbitalPeriod(completion: @escaping (_ orbitalPeriod: String) -> Void) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let planet = try decoder.decode(Planet.self, from: data)
                            completion(planet.orbitalPeriod)
                            ()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                default:
                    print("data error")
                }
            }
        }
        dataTask.resume()
    }
}
