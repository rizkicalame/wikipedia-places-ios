//
//  AddCustomLocationViewModelTests.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import XCTest

@testable import wikipedia_places_ios

final class AddCustomLocationViewModelTests: XCTestCase {

    // MARK: - Properties

    var sut: AddCustomLocationViewModel!
    var useCaseMock: AddCustomLocationUseCaseInterfaceMock!

    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        useCaseMock = AddCustomLocationUseCaseInterfaceMock()
        sut = AddCustomLocationViewModel(useCase: useCaseMock)
    }

    // MARK: - Tests

    func testShouldCallUseCaseWhenSubmitTapped() {
        // Given
        // When
        sut.onSubmitTapped()

        // Then
        XCTAssertTrue(useCaseMock.addCustomLocationNameLatitudeLongitudeCalled)
    }

    func testShouldSetCorrectFormTexts() {
        XCTAssertEqual(sut.locationFormTitle,"Name of location")
        XCTAssertEqual(sut.locationPlaceholder,"E.g. Amsterdam")
        XCTAssertEqual(sut.latitudeFormTitle,"Latitude")
        XCTAssertEqual(sut.latitudePlaceholder,"52.0000")
        XCTAssertEqual(sut.longitudeFormTitle,"Longitude")
        XCTAssertEqual(sut.longitudePlaceholder,"14.0000")
        XCTAssertEqual(sut.submitButtonTitle,"Submit")
        XCTAssertEqual(sut.navigationTitle,"Add custom location")
    }

    func testShouldNotShowErrorAndTextsWhenIdle() {
        // Given
        // When
        let errorText = sut.errorText
        let shouldDisplayErrorMessage = sut.shouldDisplayErrorMessage

        // Then
        XCTAssertTrue(errorText.isEmpty)
        XCTAssertFalse(shouldDisplayErrorMessage)
    }

    func testShouldShowErrorWhenInvalidLatitudeProvided() {
        // Given
        useCaseMock.addCustomLocationNameLatitudeLongitudeThrowableError = AddCustomLocationUseCase.ValidationErrors.invalidLatitudeProvided

        // When
        sut.onSubmitTapped()

        // Then
        XCTAssertTrue(sut.shouldDisplayErrorMessage)
        XCTAssertEqual(sut.errorText, "Please provide a valid latitude.")
    }

    func testShouldShowErrorWhenInvalidLongitudeProvided() {
        // Given
        useCaseMock.addCustomLocationNameLatitudeLongitudeThrowableError = AddCustomLocationUseCase.ValidationErrors.invalidLongitudeProvided

        // When
        sut.onSubmitTapped()

        // Then
        XCTAssertTrue(sut.shouldDisplayErrorMessage)
        XCTAssertEqual(sut.errorText, "Please provide a valid longitude.")
    }

    func testShouldShowErrorWhenUnknownErrorOccurred() {
        // Given
        useCaseMock.addCustomLocationNameLatitudeLongitudeThrowableError = APIClient.APIError.invalidKeyPathSpecified
        // When
        sut.onSubmitTapped()

        // Then
        XCTAssertTrue(sut.shouldDisplayErrorMessage)
        XCTAssertEqual(sut.errorText, "An unknown error has occurred.")
    }
}
