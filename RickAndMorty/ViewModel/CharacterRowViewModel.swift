//
//  CharacterRowViewModel.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 15/09/2023.
//

import Foundation
import SwiftUI

@MainActor
class CharacterRowViewModel: ObservableObject {
    let character: Character
    @ObservedObject var favorites: Favorite
    
    var isFavorite: Bool {
        favorites.contains(character)
    }
    
    init(character: Character, favorites: Favorite) {
        self.favorites = favorites
        self.character = character
    }
}
