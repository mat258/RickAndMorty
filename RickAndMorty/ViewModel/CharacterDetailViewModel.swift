//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation
import Combine

@MainActor
class CharacterDetailViewModel: ObservableObject {
    let character: Character
    let repository: LocationRepository
    var isLoading = false
    @Published var location: LocationDetail?
    @Published var showingAlert: Bool = false
    @Published var favorites: FavoriteProvider
    
    @Published var name: String = ""
    @Published var type: String = ""
    @Published var dimension: String = ""
    
    var favoriteButtonLabel: String {
        return favorites.contains(character) ? "Remove from Favorites" : "Add to Favorites"
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: LocationRepository = LocationRepositoryProvider.createRepository(), character: Character, favorites: FavoriteProvider) {
        self.favorites = favorites
        self.character = character
        self.repository = repository
        
        favorites.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &cancellables)
    }
    
    func fetchLastLocation() async {
        do {
            self.showingAlert = false
            self.isLoading = true
            location = try await repository.fetchLocation(withURLSting: character.location?.url)
            name = location?.name ?? ""
            type = "type: \(location?.type ?? "")"
            dimension = "dimension: \(location?.type ?? "")"
            self.isLoading = false
        } catch {
            showingAlert = true
            isLoading = false
        }
    }
    
    func toggleFavorite() {
        if favorites.contains(character) {
            favorites.remove(character)
        } else {
            favorites.add(character)
        }
    }
}
