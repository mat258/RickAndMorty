//
//  WebAPILocationDetail.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

struct LocationDetail: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
}
