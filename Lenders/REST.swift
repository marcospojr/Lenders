//
//  REST.swift
//  Lenders
//
//  Created by Marcos Junior on 01/09/20.
//  Copyright © 2020 Marcos Junior. All rights reserved.
//

import Foundation

class REST {
    
    private static let basePath = "https://a-lenders-api.herokuapp.com/users/"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadUsers() {
        guard let url = URL(string: basePath) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode ==  200 {
                    
                    guard let data = data else {return}
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        for user in users {
                            print(user._id, user.name)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print(response.statusCode)
                }
                
            } else {
                print(error!)
            }
        }
        dataTask.resume()
    }
    
    class func save(user: User, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let json = try? JSONEncoder().encode(user) else {
            onComplete(false)
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
}
