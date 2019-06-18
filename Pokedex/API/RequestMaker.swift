//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

enum RequestMakerError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
}

class RequestMaker {
    
    static let decoder = JSONDecoder()
    
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
    typealias RequestResult<T> = Result<T, RequestMakerError>
    typealias CompletionCallback<T: Decodable> = (RequestResult<T>) -> Void
    typealias SuccessCallback<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping SuccessCallback<T>) {
        make(withEndpoint: endpoint) { (result: RequestResult<T>) in
            switch result {
            case let .success(object):
                completion(object)
            case .failure:
                break
            }
        }
    }
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping CompletionCallback<T>) {
        guard let url = URL(string: "\(self.baseUrl)\(endpoint.url)") else {
            completion(.failure(.malformedURL))
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decodedObject = try RequestMaker.decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        dataTask.resume()
    }
}
