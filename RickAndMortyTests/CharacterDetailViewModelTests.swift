//
//  CharacterDetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Matias Valdes on 14/09/2023.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {
    
    @MainActor func testFetchLastLocation() async {
        let repository = LocationStubRepository(result: LocationDetail(id: 1, name: "Earth", type: "Planet", dimension: "C-137"))
        let sut = CharacterDetailViewModel(repository: repository,character: DemoData.rickCharacter, favorites: FavoriteProvider())
        await sut.fetchLastLocation()
        
        XCTAssertFalse(sut.name.isEmpty)
        XCTAssertFalse(sut.type.isEmpty)
        XCTAssertFalse(sut.dimension.isEmpty)
    }
    
    @MainActor func testToggleFavoriteAdd() async {
        let repository = LocationStubRepository(result: LocationDetail(id: 1, name: "Earth", type: "Planet", dimension: "C-137"))
        let sut = CharacterDetailViewModel(repository: repository,character: DemoData.rickCharacter, favorites: FavoriteProvider())
        await sut.fetchLastLocation()
        XCTAssertFalse(sut.favorites.contains(DemoData.rickCharacter))
        sut.toggleFavorite()
        XCTAssertTrue(sut.favorites.contains(DemoData.rickCharacter))
    }
    
    @MainActor func testToggleFavoriteRemove() async {
        let repository = LocationStubRepository(result: LocationDetail(id: 1, name: "Earth", type: "Planet", dimension: "C-137"))
        let sut = CharacterDetailViewModel(repository: repository,character: DemoData.rickCharacter, favorites: FavoriteProvider())
        await sut.fetchLastLocation()
        XCTAssertFalse(sut.favorites.contains(DemoData.rickCharacter))
        sut.toggleFavorite()
        XCTAssertTrue(sut.favorites.contains(DemoData.rickCharacter))
        sut.toggleFavorite()
        XCTAssertFalse(sut.favorites.contains(DemoData.rickCharacter))
    }
}

class LocationStubRepository: LocationRepository {
    let stubResult: LocationDetail
    init(result: LocationDetail) {
        self.stubResult = result
    }
    func fetchLocation(withURLSting urlString: String?) async throws -> RickAndMorty.LocationDetail {
        return stubResult
    }
}
