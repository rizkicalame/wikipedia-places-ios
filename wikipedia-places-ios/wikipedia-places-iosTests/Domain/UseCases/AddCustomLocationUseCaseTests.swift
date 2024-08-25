//
//  AddCustomLocationUseCaseTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest

@testable import wikipedia_places_ios

final class AddCustomLocationUseCaseTests: XCTestCase {

    var sut: AddCustomLocationUseCase!
    var repositoryMock: LocationsRepositoryInterfaceMock!

    override func setUp() {
        super.setUp()
        
        self.repositoryMock = LocationsRepositoryInterfaceMock()
        self.sut = AddCustomLocationUseCase(repository: repositoryMock)
    }

    // MARK: - Tests

    func testShouldCallRepositoryWhenCustomLocationIsAdded() {
        // Given
        let name = "Name"
        let latitude = "45.0000"
        let longitude = "12.0000"

        // When
        do {
            try self.sut.addCustomLocation(name: name, latitude: latitude, longitude: longitude)

            // Then
            XCTAssertTrue(repositoryMock.createCustomLocationLocationCalled)
        } catch {
            XCTFail("Expected a non failure.")
        }

    }

    func testShouldThrowErrorWhenInvalidLatIsProvided() {
        // Given
        let name = "Name"
        let latitude = "some text which is not a valid latitude"
        let longitude = "13.000"

        // When
        do {
            try self.sut.addCustomLocation(name: name, latitude: latitude, longitude: longitude)
            XCTFail("Expected a failure.")
        } catch {
            // Then
            XCTAssertFalse(repositoryMock.createCustomLocationLocationCalled)
            XCTAssertEqual(error as! AddCustomLocationUseCase.ValidationErrors, AddCustomLocationUseCase.ValidationErrors.invalidLatitudeProvided)
        }
    }

    func testShouldThrowErrorWhenInvalidLongIsProvided() {
        // Given
        let name = "Name"
        let latitude = "13.000"
        let longitude = "some text which is not a valid longitude"

        // When
        do {
            try self.sut.addCustomLocation(name: name, latitude: latitude, longitude: longitude)
            XCTFail("Expected a failure.")
        } catch {
            // Then
            XCTAssertFalse(repositoryMock.createCustomLocationLocationCalled)
            XCTAssertEqual(error as! AddCustomLocationUseCase.ValidationErrors, AddCustomLocationUseCase.ValidationErrors.invalidLongitudeProvided)
        }
    }
}
