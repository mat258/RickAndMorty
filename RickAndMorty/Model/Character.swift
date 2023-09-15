//
//  Character.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

struct Character: Codable,Hashable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location?
    let location: Location?
    let image: String
}
