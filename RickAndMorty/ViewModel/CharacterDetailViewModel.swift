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
    private let character: Character
    private let repository: LocationRepository
    private(set) var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var location: LocationDetail?
    @Published private(set) var showingAlert: Bool = false
    @Published private(set) var favorites: FavoriteProvider
    
    @Published private(set) var name: String = ""
    @Published private(set) var type: String = ""
    @Published private(set) var dimension: String = ""
    
    var favoriteButtonLabel: String {
        return favorites.contains(character) ? "Remove from Favorites" : "Add to Favorites"
    }
    
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
            type = "Type: \(location?.type ?? "")"
            dimension = "Dimension: \(location?.dimension ?? "")"
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
