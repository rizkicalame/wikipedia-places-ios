//
//  WikipediaDeeplinkHelperTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
import ConcurrencyExtras
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

    func testShouldThrowErrorWhenURLCannotBeOpened() async {
        await withMainSerialExecutor {
            // Given
            let mockURLOpener = URLOpeningMock()
            let mockErrorHandler = ErrorHandlerInterfaceMock()

            sut = WikipediaDeeplinkURLOpener(urlOpener: mockURLOpener)
            let domainModel = LocationDomainModel(name: "Name", latitude: 1.1234, longitude: 2.1234)

            mockURLOpener.canOpenURLReturnValue = false

            // When
            await sut.openDeeplinkWithCoordinatesIfPossible(latitude: domainModel.latitude,
                                                      longitude: domainModel.longitude,
                                                      in: UINavigationController(),
                                                      errorHandler: mockErrorHandler)

            // Then
            await Task.yield()
            XCTAssertTrue(mockErrorHandler.handleErrorInCalled)
        }
    }

    func testShouldThrowErrorWhenDeeplinkFailed() async {
        await withMainSerialExecutor {
            // Given
            let mockURLOpener = URLOpeningMock()
            let mockErrorHandler = ErrorHandlerInterfaceMock()

            sut = WikipediaDeeplinkURLOpener(urlOpener: mockURLOpener)
            let domainModel = LocationDomainModel(name: "Name", latitude: 1.1234, longitude: 2.1234)

            mockURLOpener.canOpenURLReturnValue = true
            mockURLOpener.openURLReturnValue = false

            // When
            await sut.openDeeplinkWithCoordinatesIfPossible(latitude: domainModel.latitude,
                                                      longitude: domainModel.longitude,
                                                      in: UINavigationController(),
                                                      errorHandler: mockErrorHandler)

            // Then
            await Task.yield()
            XCTAssertTrue(mockErrorHandler.handleErrorInCalled)
        }
    }
}
