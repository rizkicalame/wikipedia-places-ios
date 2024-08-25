//
//  LocationsRepositoryTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 24/08/2024.
//

import XCTest
@testable import wikipedia_places_ios

final class LocationsRepositoryTests: XCTestCase {

    // MARK: - Properties

    var sut: LocationsRepository!
    var apiClientMock: APIClientInterfaceMock<[LocationDataModel]>!
    var cache: CustomLocationsCacheInterface!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        self.apiClientMock = APIClientInterfaceMock()
        self.cache = CustomLocationsCache()
        self.sut = LocationsRepository(apiClient: apiClientMock, customLocationsCache: cache)
    }

    // MARK: - Tests

    func testShouldReturnLocationsFromAPI() {
        // Given
        let dataModel = LocationDataModel(name: "name", latitude: 50.0000, longitude: 14.0000)
        apiClientMock.performRequestPathMethodKeyPathReturnValue = [dataModel]

        // When
        Task {
            let result = try await sut.getLocations()

            // Then
            XCTAssertFalse(result.isEmpty)
            XCTAssertEqual(result.first?.name, dataModel.name)
            XCTAssertEqual(result.first?.latitude, dataModel.latitude)
            XCTAssertEqual(result.first?.longitude, dataModel.longitude)
        }
    }

    func testShouldThrowErrorWhenAPIClientThrows() {
        // Given
        let error = APIClient.APIError.invalidResponse
        apiClientMock.performRequestPathMethodKeyPathThrowableError = error

        let expectation = XCTestExpectation(description: "Expected error to be thrown.")

        // When
        Task {
            do {
                _ = try await sut.getLocations()
                XCTFail("Failed to throw an error.")
            } catch {
                expectation.fulfill()
            }

            await fulfillment(of: [expectation])
        }
    }

    func testShouldRetrieveCustomLocations() {
        // Given
        let dataModel = LocationDataModel(name: "location 1", latitude: 50.0000, longitude: 14.0000)
        let customLocationDataModel = LocationDataModel(name: "customLocation", latitude: 12.000, longitude: 13.000)
        apiClientMock.performRequestPathMethodKeyPathReturnValue = [dataModel]
        cache.addItems([customLocationDataModel])

        // When
        Task {
            let result = try await sut.getLocations()

            // Then
            XCTAssertEqual(result.count, 2)

            // Test first model is the model from the API
            XCTAssertEqual(result[0].name, dataModel.name)
            XCTAssertEqual(result[0].latitude, dataModel.latitude)
            XCTAssertEqual(result[0].longitude, dataModel.longitude)

            // Test second model is the cached model
            XCTAssertEqual(result[1].name, customLocationDataModel.name)
            XCTAssertEqual(result[1].latitude, customLocationDataModel.latitude)
            XCTAssertEqual(result[1].longitude, customLocationDataModel.longitude)
        }
    }

    func testShouldCreateCustomLocation() {
        // Given
        let customLocationDataModel = LocationDomainModel(name: "customLocation", latitude: 12.000, longitude: 13.000)
        apiClientMock.performRequestPathMethodKeyPathReturnValue = []

        // When
        Task {
            let initialResult = try await sut.getLocations()
            XCTAssertEqual(initialResult.count, 0)
            self.sut.createCustomLocation(location: customLocationDataModel)

            // Then

            let result = try await sut.getLocations()
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result[0].name, customLocationDataModel.name)
            XCTAssertEqual(result[0].latitude, customLocationDataModel.latitude)
            XCTAssertEqual(result[0].longitude, customLocationDataModel.longitude)
        }
    }
}


