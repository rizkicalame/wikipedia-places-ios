//
//  WikipediaDeeplinkHelperTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
@testable import wikipedia_places_ios

final class WikipediaDeeplinkHelperTests: XCTestCase {

    // MARK: - Tests

    func testShouldGetDeeplinkURL() {
        // Given
        let domainModel = LocationDomainModel(name: "Name", latitude: 1.1234, longitude: 2.1234)

        // When
        let deeplinkURL = WikipediaDeeplinkHelper.getCoordinatesDeeplinkURL(location: domainModel)

        // Then
        XCTAssertEqual(deeplinkURL, "wikipedia://places/?WMFPlacesCoordinates=1.1234,2.1234")
    }
}
