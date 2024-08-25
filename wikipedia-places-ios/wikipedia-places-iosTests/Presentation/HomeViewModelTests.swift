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
    func testShouldInformDelegateOfLocationTap() {
        // Given
        let domainModel = LocationDomainModel(name: "Name", latitude: 1.000, longitude: 2.000)
        let mockDelegate = HomeViewModelDelegateMock()
        sut.delegate = mockDelegate

        // When
        sut.onRowTapped(location: domainModel)

        // Then
        XCTAssertTrue(mockDelegate.didTapLocationLocationSenderCalled)
        XCTAssertEqual(mockDelegate.didTapLocationLocationSenderReceivedArguments?.location.name, domainModel.name)
        XCTAssertEqual(mockDelegate.didTapLocationLocationSenderReceivedArguments?.location.latitude, domainModel.latitude)
        XCTAssertEqual(mockDelegate.didTapLocationLocationSenderReceivedArguments?.location.longitude, domainModel.longitude)
    }

    @MainActor
    func testShouldInformDelegateOfCustomLocationTap() {
        // Given
        let mockDelegate = HomeViewModelDelegateMock()
        sut.delegate = mockDelegate

        // When
        sut.onAddCustomLocationTapped()

        // Then
        XCTAssertTrue(mockDelegate.didTapAddCustomLocationSenderCalled)
    }
}
