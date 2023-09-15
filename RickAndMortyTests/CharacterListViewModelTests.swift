//
//  CharacterListViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Matias Valdes on 14/09/2023.
//

import XCTest
@testable import RickAndMorty

final class CharacterListViewModelTests: XCTestCase {
    
    @MainActor func testRetry() async {
        let stubRepository = StubRepository(results: DemoData.fiveCharacters)
        let sut = CharacterListViewModel(repository: stubRepository)
        await sut.retryTapped()
        XCTAssertEqual(sut.characters.count, 5)
    }
    
    @MainActor func testFetchCharacters() async {
        let stubRepository = StubRepository(results: DemoData.fiveCharacters)
        let sut = CharacterListViewModel(repository: stubRepository)
        await sut.fetchCharacters()
        XCTAssertEqual(sut.characters.count, 5)
    }
    
    @MainActor func testShowNewIndex() async {
        let stubRepository = StubRepository(results: DemoData.fiveCharacters)
        let sut = CharacterListViewModel(repository: stubRepository)
        await sut.fetchCharacters()
        await sut.listViewShownWithIndex(3)
        XCTAssertEqual(sut.characters.count, 10)
    }
}

class StubRepository: CharacterRepository {
    var results: [Character] = []
    let stubResult: [Character]
    init(results: [Character]) {
        self.stubResult = results
    }
    func fetchResult(forPage page: Int) async {
        results.append(contentsOf: stubResult)
    }
}
