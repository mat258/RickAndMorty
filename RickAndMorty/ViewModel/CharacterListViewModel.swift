//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import Foundation

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
    
    @Published var characters: [Character] = []
    @Published var loadingState: LoadingState?
    @Published var showingAlert: ShowAlertState?
    @Published var favorites = Favorite()
    
    let repository: CharacterRepository
    private var resultsCurrentPage = 1
    private static let fetchNewPageThreshold = 2
    
    init(repository: CharacterRepository = CharacterRepositoryProvider.createRepository()) {
        self.repository = repository
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
