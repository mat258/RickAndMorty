//
//  CharacterDetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Matias Valdes on 14/09/2023.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {

    @MainActor func testDetailViewModelCharacter() async {
        let repository = LocationStubRepository(result: LocationDetail(id: 1, name: "Earth", type: "Planet", dimension: "C-137"))
        let sut = CharacterDetailViewModel(repository: repository,character: DemoData.rickCharacter, favorites: Favorite())
        await sut.fetchLastLocation()
        
        XCTAssertFalse(sut.name.isEmpty)
        XCTAssertFalse(sut.type.isEmpty)
        XCTAssertFalse(sut.dimension.isEmpty)
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
