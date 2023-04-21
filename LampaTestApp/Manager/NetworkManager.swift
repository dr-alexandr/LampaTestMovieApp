//
//  NetworkManager.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 19.04.2023.
//

import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum HTTPScheme: String {
    case http
    case https
}

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var path: String { get }
}

// MARK: - TheMovieDb API
enum TheMovieDbAPI: API {
    
    case getPopularMovies
    case getTopRatedMovies
    
    var scheme:HTTPScheme {
        switch self {
        case .getPopularMovies, .getTopRatedMovies:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getPopularMovies, .getTopRatedMovies:
            return "api.themoviedb.org"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPopularMovies, .getTopRatedMovies:
            let params = [
                URLQueryItem(name: "api_key", value: "ed0957c3c3f2acb89d27b394e9612d5e")
            ]
            return params
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopularMovies, .getTopRatedMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        }
    }
}


// MARK: - BuildURL Func
private func buildURL(endpoint: API) -> URLComponents {
    var components = URLComponents()
    components.scheme = endpoint.scheme.rawValue
    components.host = endpoint.baseURL
    components.queryItems = endpoint.parameters
    components.path = endpoint.path
    return components
}

// MARK: - NetworkManager Class

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void)
    var task: URLSessionDataTask? { get set }
}

final class NetworkManager: NetworkManagerProtocol {
    
    var task: URLSessionDataTask?
    func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void) {
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else {
            completion(.failure(NetworkError.outdated))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: urlRequest) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Unknown error: \(error)")
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode || 500 == httpResponse.statusCode
            else {
                completion(.failure(NetworkError.unauthorized))
                return
            }
            
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } else {
                let error = NetworkError.badResponse
                completion(.failure(error))
            }
        }
        task?.resume()
    }
    
    deinit {
        print("Deallocation \(self)")
    }
}
