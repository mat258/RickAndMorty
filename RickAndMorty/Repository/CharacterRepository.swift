//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

protocol CharacterRepository {
    func fetchResult(forPage page: Int) async throws
    var results: [Character] { get }
}

enum RepositoryError: Error {
    case invalidURL
}

class CharacterAPIRepository: CharacterRepository {
    
    private(set) var results = [Character]()
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    private(set) var didFetchAll = false
    
    func fetchResult(forPage page: Int) async throws {
        
        guard !didFetchAll else { return }
        
        guard let url = URL(string: "\(CharacterAPI.baseURL)\(CharacterAPI.path)\(page)") else {
            throw RepositoryError.invalidURL
        }
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(ResultAPIResponse.self, from: data)
        
        didFetchAll = response.info.next == nil
        results.append(contentsOf: response.results)
    }
}
