//
//  CustomLocationsCacheTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
import ConcurrencyExtras
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

    func testShouldAddItemsInMemory() async {
        // Given
        let item = LocationDataModel(name: "Name", latitude: 14.00, longitude: 15.00)

        // When
        await sut.addLocations([item])

        // Then
        let locations = await sut.getCustomLocations()
        XCTAssertFalse(locations.isEmpty)
        XCTAssertEqual(locations.count, 1)
        XCTAssertEqual(locations[0].name, item.name)
        XCTAssertEqual(locations[0].latitude, item.latitude)
        XCTAssertEqual(locations[0].longitude, item.longitude)
    }

    func testShouldClearCache() async {
        // Given
        let item = LocationDataModel(name: "Name", latitude: 14.00, longitude: 15.00)
        await sut.addLocations([item])

        let locations = await sut.getCustomLocations()
        XCTAssertFalse(locations.isEmpty)

        // When
        await sut.clearCache()

        // Then
        let newLocations = await sut.getCustomLocations()
        XCTAssertTrue(newLocations.isEmpty)
    }
}
