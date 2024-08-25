//
//  CustomLocationsCacheTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest

@testable import wikipedia_places_ios

final class CustomLocationsCacheTests: XCTestCase {

    // MARK: - Properties

    var sut: CustomLocationsCache!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        
        sut = CustomLocationsCache()
    }

    // MARK: - Tests

    func testShouldAddItemsInMemory() {
        // Given
        let item = LocationDataModel(name: "Name", latitude: 14.00, longitude: 15.00)

        // When
        sut.addItems([item])

        // Then
        XCTAssertFalse(sut.inMemoryLocations.isEmpty)
        XCTAssertEqual(sut.inMemoryLocations.count, 1)
        XCTAssertEqual(sut.inMemoryLocations[0].name, item.name)
        XCTAssertEqual(sut.inMemoryLocations[0].latitude, item.latitude)
        XCTAssertEqual(sut.inMemoryLocations[0].longitude, item.longitude)
    }

    func testShouldClearCache() {
        // Given
        let item = LocationDataModel(name: "Name", latitude: 14.00, longitude: 15.00)
        sut.addItems([item])
        XCTAssertFalse(sut.inMemoryLocations.isEmpty)

        // When
        sut.clearCache()

        // Then
        XCTAssertTrue(sut.inMemoryLocations.isEmpty)
    }
}
