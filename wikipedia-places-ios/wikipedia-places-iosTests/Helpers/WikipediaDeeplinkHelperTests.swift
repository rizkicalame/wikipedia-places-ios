//
//  WikipediaDeeplinkHelperTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
@testable import wikipedia_places_ios

final class WikipediaDeeplinkURLOpenerTests: XCTestCase {

    // MARK: - Properties

    var sut: WikipediaDeeplinkURLOpener!

    // MARK: - Tests

    func testShouldGetDeeplinkURL() {
        // Given
        sut = WikipediaDeeplinkURLOpener()
        let domainModel = LocationDomainModel(name: "Name", latitude: 1.1234, longitude: 2.1234)

        // When
        let deeplinkURL = sut.getCoordinatesDeeplinkURL(latitude: domainModel.latitude, longitude: domainModel.longitude)

        // Then
        XCTAssertEqual(deeplinkURL?.absoluteString, "wikipedia://places/?WMFPlacesCoordinates=1.1234,2.1234")
    }
}
