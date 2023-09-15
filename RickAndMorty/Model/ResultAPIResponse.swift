//
//  ResultWebAPIResponse.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

struct ResultAPIResponse: Codable {
    let results: [Character]
    let info: APIInfo
}

struct APIInfo: Codable {
    let next: String?
}
