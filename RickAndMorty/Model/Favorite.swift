//
//  Favorite.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

class Favorite: ObservableObject {
    @Published var characters: Set<Int> = []

    func contains(_ character: Character?) -> Bool {
        guard let character = character else { return false }
        return characters.contains(character.id)
    }

    func add(_ character: Character?) {
        guard let character = character else { return }
        characters.insert(character.id)
    }

    func remove(_ character: Character?) {
        guard let character = character else { return }
        characters.remove(character.id)
    }
}
