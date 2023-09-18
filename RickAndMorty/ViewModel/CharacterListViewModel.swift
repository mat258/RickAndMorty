//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation
import Combine

@MainActor
class CharacterListViewModel: ObservableObject {
    enum LoadingState: Equatable {
        case fullscreen
        case morePages
    }
    enum ShowAlertState: Equatable {
        case retry
        case informative
    }
    
    @Published private(set) var characters: [Character] = []
    @Published private(set) var loadingState: LoadingState?
    @Published private(set) var showingAlert: ShowAlertState?
    @Published private(set) var favorites = FavoriteProvider()
    @Published var selectedCharacter: Character?
    private var cancellables = Set<AnyCancellable>()
    
    private let repository: CharacterRepository
    private var resultsCurrentPage = 1
    private static let fetchNewPageThreshold = 2
    var favoriteAmountDisplay: String {
        return "Favorites: \(favorites.amount())"
    }
    
    init(repository: CharacterRepository = CharacterRepositoryProvider.createRepository()) {
        self.repository = repository
        
        favorites.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &cancellables)
    }
    
    func retryTapped() async {
        await fetchCharacters()
    }
    
    func fetchCharacters() async {
        do {
            showingAlert = nil
            self.loadingState = .fullscreen
            try await repository.fetchResult(forPage: resultsCurrentPage)
            characters = repository.results
            loadingState = nil
        } catch {
            showingAlert = .retry
        }
    }
    
    func listViewShownWithIndex(_ index: Int) async {
        guard index == characters.count - Self.fetchNewPageThreshold, loadingState != .morePages else { return }
        resultsCurrentPage += 1
        loadingState = .morePages
        showingAlert = nil
        do {
            try await repository.fetchResult(forPage: resultsCurrentPage)
            characters = repository.results
            loadingState = nil
        } catch {
            resultsCurrentPage -= 1
            loadingState = nil
            showingAlert = .informative
        }
    }
}
