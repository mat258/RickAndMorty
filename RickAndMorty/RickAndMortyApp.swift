//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    @StateObject var viewModel = CharacterListViewModel()
    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: viewModel)
        }
    }
}
