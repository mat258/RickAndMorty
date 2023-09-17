//
//  LocationRepositoryProvider.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 15/09/2023.
//

import Foundation

struct LocationRepositoryProvider {
    static func createRepository() -> LocationRepository {
        if CommandLine.arguments.contains("-UITests") {
            return LocationMockRepository()
        } else {
            return LocationAPIRepository()
        }
    }
}

class LocationMockRepository: LocationRepository {
    
    func fetchLocation(withURLSting urlString: String?) async throws -> LocationDetail {
        return LocationDetail(id: 1, name: "Earth", type: "city", dimension: "C-137")
    }
}
