//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Matias Valdes on 14/09/2023.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        NavigationSplitView {
            list
                .overlay(
                    ZStack {
                        if viewModel.loadingState == .fullscreen {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }
                )
            
                .navigationTitle("Characters")
                .alert("Something happened!", isPresented: .init(get: {
                    viewModel.showingAlert == .retry
                }, set: { _ in
                })) {
                    Button("Retry") {
                        Task{
                            await viewModel.retryTapped()
                        }
                    }
                }
                .alert("Something happened!", isPresented: .init(get: {
                    viewModel.showingAlert == .informative
                }, set: { _ in
                })) {
                } message: {
                    Text("Try scrolling again to get more characters")
                }
            
        } detail: {
            if let selectedCharacter = viewModel.selectedCharacter {
                CharacterDetailView(viewModel: CharacterDetailViewModel(character: selectedCharacter, favorites: viewModel.favorites))
            }
        }
        .onLoad() {
            Task{
                await viewModel.fetchCharacters()
            }
        }
    }
    
    private var list: some View {
        List(selection: $viewModel.selectedCharacter) {
            Section {
                ForEach(viewModel.characters.indices, id: \.self) { characterIndex in
                    let character = viewModel.characters[characterIndex]
                    NavigationLink(value: character) {
                        CharacterRow(viewModel: CharacterRowViewModel(character: character, favorites: viewModel.favorites))
                    }
                    .accessibilityIdentifier("characterCell-\(characterIndex)")
                    .onAppear {
                        Task {
                            await viewModel.listViewShownWithIndex(characterIndex)
                        }
                    }
                }
            } header: {
                HStack{
                    Spacer()
                    Text(viewModel.favoriteAmountDisplay)
                }
            }
            
            if viewModel.loadingState == .morePages {
                HStack {
                    Spacer()
                    Text("Loading next page...")
                        .font(.headline)
                    Spacer()
                }
                .padding()
            }
        }
        .listStyle(.inset)
        .accessibilityIdentifier("characterList")
    }
}


struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel())
    }
}
