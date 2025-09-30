//
//  HomeViewModelTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest

@testable import wikipedia_places_ios

final class HomeViewModelTests: XCTestCase {

    // MARK: - Properties

    var sut: HomeViewModel!
    var useCaseMock: GetLocationsUseCaseInterfaceMock!

    // MARK: - XCTestCase

    @MainActor
    override func setUp() {
        super.setUp()
        useCaseMock = GetLocationsUseCaseInterfaceMock()
        sut = HomeViewModel(getLocationsUseCase: useCaseMock)
    }

    // MARK: - Tests

    func testRefreshingShouldCallUseCase() {
        // Given
        useCaseMock.getLocationsReturnValue = []

        // When
        Task {
            do {
                await sut.refreshLocations()

                // Then
                XCTAssertTrue(useCaseMock.getLocationsCalled)
            }
        }
    }

    @MainActor
    func testShouldInformEventSubscriberOfLocationTap() {
        // Given
        let domainModel = LocationDomainModel(name: "Name", latitude: 1.000, longitude: 2.000)
        let expectation = XCTestExpectation(description: "Expected closure event to be called")
        sut.onLocationTapped = { location in
            // Then
            XCTAssertEqual(location.name, domainModel.name)
            XCTAssertEqual(location.latitude, domainModel.latitude)
            XCTAssertEqual(location.longitude, domainModel.longitude)
            expectation.fulfill()
        }

        // When
        sut.onRowTapped(location: domainModel)

        wait(for: [expectation])
    }

    @MainActor
    func testShouldInformDelegateOfCustomLocationTap() {
        // Given
        let expectation = XCTestExpectation(description: "Expected closure event to be called")
        sut.onAddCustomLocationTapped = {
            expectation.fulfill()
        }

        // When
        sut.addCustomLocation()

        // Then
        wait(for: [expectation])
    }

    @MainActor
    func testShouldHaveCorrectStaticTexts() {
        XCTAssertEqual(sut.navigationTitle, "Locations")
        XCTAssertEqual(sut.addCustomLocationButtonTitle, "Add custom location")
    }

    @MainActor
    func testShouldReturnErrorTexts() {
        // Given
        let error = AddCustomLocationUseCase.ValidationErrors.invalidLatitudeProvided
        useCaseMock.getLocationsThrowableError = error

        Task {
            await self.sut.refreshLocations()

            // When
            let text = sut.errorText

            // Then
            XCTAssertFalse(text.isEmpty)
        }
    }
}
