//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class RequestMaker {
    
    var baseUrl: String
    
    init() {
        self.baseUrl = "http://localhost:3000/"
    }
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    enum Endpoint {
        case list
        case details(query: String)
        case moves
        case move(query: String)
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            case .moves:
                return "moves"
            case let .move(query):
                return "move/\(query)"
            }
        }
    }
    
    let session = URLSession.shared
    typealias CompletionCallback<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping CompletionCallback<T>) {
        guard let url = URL(string: "\(self.baseUrl)\(endpoint.url)") else {
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("não veio")
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(decodedObject)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
