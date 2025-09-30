//
//  WikipediaCoordinatorTests.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import XCTest
import ConcurrencyExtras
@testable import wikipedia_places_ios

@MainActor
final class WikipediaCoordinatorTests: XCTestCase {

    // MARK: - Properties

    var window: UIWindow!
    var sut: WikipediaCoordinator!
    var navigationController: UINavigationController!

    // MARK: - Base dependencies

    var mockDeeplinkOpener: WikipediaDeeplinkURLOpenerInterfaceMock!
    var mockCustomLocationsCache: CustomLocationsCacheInterfaceMock!
    var mockAPIClient: APIClientInterfaceMock<[LocationDataModel]>!
    var mockErrorHandler: ErrorHandlerInterfaceMock!

    // MARK: - Tests

    func testShouldSetViewControllersWhenStarted() async {
        await withMainSerialExecutor {
            // Given
            let location = LocationDomainModel(name: "", latitude: 12.000, longitude: 14.000)
            let navigationController = UINavigationController()

            self.mockDeeplinkOpener = WikipediaDeeplinkURLOpenerInterfaceMock()
            self.mockErrorHandler = ErrorHandlerInterfaceMock()

            sut = WikipediaCoordinator(location: location,
                                       navigationController: navigationController,
                                       deeplinkOpener: mockDeeplinkOpener,
                                       errorHandler: mockErrorHandler)

            // When
            sut.start()

            // Then
            await Task.yield()
            XCTAssertTrue(mockDeeplinkOpener.openDeeplinkWithCoordinatesIfPossibleLatitudeLongitudeInErrorHandlerCalled)
        }
    }
}

