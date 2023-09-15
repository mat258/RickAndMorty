//
//  LocationRepository.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

protocol LocationRepository {
    func fetchLocation(withURLSting urlString: String?) async throws -> LocationDetail
}

class LocationAPIRepository: LocationRepository {
        
    private let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    var didFetchAll = false
    
    func fetchLocation(withURLSting urlString: String?) async throws -> LocationDetail {
        
        guard let currentURLString = urlString, let url = URL(string: currentURLString) else {
            throw RepositoryError.invalidURL
        }
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(LocationDetail.self, from: data)
        return response
    }
}
