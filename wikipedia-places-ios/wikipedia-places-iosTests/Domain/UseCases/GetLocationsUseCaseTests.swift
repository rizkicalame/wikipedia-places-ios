//
//  GetLocationsUseCaseTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest

@testable import wikipedia_places_ios

final class GetLocationsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: GetLocationsUseCase!
    var repositoryMock: LocationsRepositoryInterfaceMock!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        self.repositoryMock = LocationsRepositoryInterfaceMock()
        self.sut = GetLocationsUseCase(repository: repositoryMock)
    }

    // MARK: - Tests

    func testShouldCallRepositoryAndReceivingResultsWhenFetchingLocations() {
        // Given
        let mockResults = [LocationDomainModel(name: "Name", latitude: 14.00, longitude: 15.00)]
        repositoryMock.getLocationsReturnValue = mockResults

        // When
        Task {
            do {
                // Then
                let result = try await sut.getLocations()

                XCTAssertTrue(repositoryMock.getLocationsCalled)
                XCTAssertEqual(result.count, mockResults.count)

                let mockResult = mockResults.first!
                XCTAssertEqual(result.first!.name, mockResult.name)
                XCTAssertEqual(result.first!.latitude, mockResult.latitude)
                XCTAssertEqual(result.first!.longitude, mockResult.longitude)
            } catch {
                XCTFail("Did not expect a failure.")
            }
        }
    }

    func testShouldThrowError() {
        // Given
        repositoryMock.getLocationsThrowableError = APIClient.APIError.invalidResponse

        // When
        Task {
            do {
                // Then
                _ = try await sut.getLocations()
                XCTFail("Expected a failure.")
            } catch {
                XCTAssertNotNil(error)
            }
        }
    }
}
