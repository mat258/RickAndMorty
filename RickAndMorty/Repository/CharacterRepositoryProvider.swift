//
//  RepositoryProvider.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 15/09/2023.
//

import Foundation

struct CharacterRepositoryProvider {
    static func createRepository() -> CharacterRepository {
        if CommandLine.arguments.contains("-UITests") {
            return CharacterMockRepository()
        } else {
            return CharacterAPIRepository()
        }
    }
}

class CharacterMockRepository: CharacterRepository {
    private(set) var results: [Character] = [Character]()
    func fetchResult(forPage page: Int) async throws {
        results.append(contentsOf: [Character(id: 1, name: "Rick", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 2, name: "Morty", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 3, name: "Mr meeseeks", status: "Alive", species: "meeseeks", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 4, name: "Jerry", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 5, name: "Beth", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 6, name: "Summer", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 7, name: "Alien Rick", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal"), Character(id: 8, name: "Alien Morty", status: "Alive", species: "Human", gender: "Male", origin: Location(url: "Earth"), location: Location(url: "Earth"), image: "placeholder-portal")])
    }
}
