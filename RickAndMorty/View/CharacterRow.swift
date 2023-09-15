//
//  CharacterRow.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import SwiftUI

struct CharacterRow: View {
    @StateObject var viewModel: CharacterRowViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack() {
                
                if let url = URL(string: viewModel.character.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        placeHolderImage
                    }
                } else {
                    placeHolderImage
                }
                VStack(alignment: .leading) {
                    Text(viewModel.character.name)
                        .font(.title2)
                    HStack {
                        Text(viewModel.character.status)
                            .font(.body)
                        Text("-")
                            .font(.body)
                        Text(viewModel.character.species)
                            .font(.body)
                    }
                }
                Spacer()
                if viewModel.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .accessibilityIdentifier("favorite")
                }
            }
        }
    }
}

private var placeHolderImage: some View {
    Image("placeholder-portal")
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1, name: "Rick", status: "Earth", species: "Human", gender: "Male", origin: Location(url: "https://rickandmortyapi.com/api/location/3"), location: Location(url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        let favorites = Favorite()
        CharacterRow(viewModel: CharacterRowViewModel(character: character, favorites: favorites))
    }
}
