//
//  HomeCoordinatorTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
import SwiftUI
@testable import wikipedia_places_ios

@MainActor
final class HomeCoordinatorTests: XCTestCase {

    // MARK: - Properties

    var window: UIWindow!
    var sut: HomeCoordinator!
    var navigationController: UINavigationController!

    // MARK: - Base dependencies

    var mockDeeplinkOpener: WikipediaDeeplinkURLOpenerInterfaceMock!
    var mockCustomLocationsCache: CustomLocationsCacheInterfaceMock!
    var mockAPIClient: APIClientInterfaceMock<[LocationDataModel]>!
    var mockErrorHandler: ErrorHandlerInterfaceMock!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        window.makeKeyAndVisible()

        let baseDependencies = setUpBaseDependencies()

        navigationController = UINavigationController()
        sut = HomeCoordinator(baseDependencies: baseDependencies, navigationController: navigationController)

        // Load view
        window.rootViewController = navigationController

        _ = window.rootViewController?.view
    }

    // MARK: - Tests

    func testShouldSetViewControllersWhenStarted() {
        // Given
        // When
        sut.start()

        // Then

        XCTAssertFalse(navigationController.viewControllers.isEmpty)
        XCTAssertTrue(navigationController.viewControllers.first! is UIHostingController<HomeView>)
    }

    private func setUpBaseDependencies() -> BaseDependenciesInterface {
        mockDeeplinkOpener = WikipediaDeeplinkURLOpenerInterfaceMock()
        mockCustomLocationsCache = CustomLocationsCacheInterfaceMock()
        mockAPIClient = APIClientInterfaceMock()
        mockErrorHandler = ErrorHandlerInterfaceMock()

        let baseDependencies = BaseDependenciesInterfaceMock()
        baseDependencies.apiClient = mockAPIClient
        baseDependencies.customLocationsCache = mockCustomLocationsCache
        baseDependencies.deeplinkOpener = mockDeeplinkOpener
        baseDependencies.errorHandler = mockErrorHandler

        return baseDependencies
    }
}
