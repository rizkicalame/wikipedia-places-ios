//
//  HomeCoordinatorTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest
import SwiftUI
@testable import wikipedia_places_ios

final class HomeCoordinatorTests: XCTestCase {

    // MARK: - Properties

    var window: UIWindow!
    var sut: HomeCoordinator!
    var navigationController: UINavigationController!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        window.makeKeyAndVisible()
        
        navigationController = UINavigationController()
        sut = HomeCoordinator(navigationController: navigationController)

        // Load view
        window.rootViewController = navigationController

        _ = window.rootViewController?.view
    }

    // MARK: - Tests
    @MainActor
    func testShouldSetViewControllersWhenStarted() {
        // Given
        // When
        sut.start()

        // Then

        XCTAssertFalse(navigationController.viewControllers.isEmpty)
        XCTAssertTrue(navigationController.viewControllers.first! is UIHostingController<HomeView>)
    }
}
