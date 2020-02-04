//
//  Network.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

enum Result<T,E> where E: Error{
    case success(T)
    case failure(E)
}

enum APIError: Error{
    case requestFailed
    case responseUnsuccessful
    case invalidData
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        }
    }
}

protocol APIProtocole: AnyObject {
    func get<T: Decodable>(url: URLRequest, completion: @escaping (Result<T, APIError>) -> Void)
}

protocol HTTPSessionProtocole: AnyObject {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class HTTPSession: HTTPSessionProtocole {
    
    private let session :URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: url, completionHandler: completionHandler)
    }
}

class APIClient: APIProtocole {
    
    private let session: HTTPSessionProtocole
    
    init() {
        session = HTTPSession()
    }
    
    func get<T>(url: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else{
                completion(Result.failure(.requestFailed))
                return
            }
            guard httpResponse.statusCode == 200 else{
                completion(Result.failure(.responseUnsuccessful))
                return
            }
            guard let data = data else {
                completion(Result.failure(.responseUnsuccessful))
                return
            }
            do{
                let genericModel = try JSONDecoder().decode(T.self, from: data)
                return completion(Result.success(genericModel))
            }catch{
                completion(Result.failure(.invalidData))
                return
            }
        }.resume()
    }
}
