//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text(viewModel.name)
                .font(.largeTitle)
            Spacer()
            Text(viewModel.type)
            Text(viewModel.dimension)
            Spacer()
            
            Button(viewModel.favoriteButtonLabel) {
                viewModel.toggleFavorite()
            }
            .accessibilityIdentifier("favoriteButton")
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .overlay(
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        )
        .navigationTitle("Last location")
        .navigationBarTitleDisplayMode(.inline)
        .onLoad() {
            Task{
                await viewModel.fetchLastLocation()
            }
        }
        .alert("Try again!", isPresented: .init(get: {
            viewModel.showingAlert
        }, set: { _ in
        })) {
            Button("Cancel", role: .cancel) { }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1, name: "Rick", status: "Earth", species: "Human", gender: "Male", origin: Location(url: "https://rickandmortyapi.com/api/location/3"), location: Location(url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        let favorites = Favorite()
        let viewModel = CharacterDetailViewModel(character: character, favorites: favorites)
        CharacterDetailView(viewModel: viewModel)
    }
}
