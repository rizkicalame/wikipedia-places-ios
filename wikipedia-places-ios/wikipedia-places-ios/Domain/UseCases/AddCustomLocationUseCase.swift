//
//  AddCustomLocationUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

/// Interface for this use case implementations.
protocol AddCustomLocationUseCaseInterface {
    func addCustomLocation(name: String?, latitude: String, longitude: String) throws
}

final class AddCustomLocationUseCase: AddCustomLocationUseCaseInterface {

    // MARK: - ValidationError

    enum ValidationErrors: Error {
        case invalidLatitudeProvided
        case invalidLongitudeProvided
    }

    // MARK: - Properties

    private let repository: LocationsRepositoryInterface

    // MARK: - Init

    init(repository: LocationsRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - AddCustomLocationUseCaseInterface
    
    /// Adds a custom location based on name and coordinates
    /// - Parameters:
    ///   - name: The name of the location. Optional.
    ///   - latitude: The latitude of the location. Should be a string castable to a Double, otherwise throws an error.
    ///   - longitude: The longitude of the location. Should be a string castable to a Double, otherwise throws an error.
    func addCustomLocation(name: String?, latitude: String, longitude: String) throws {
        guard let latitude = Double(latitude) else {
            throw(ValidationErrors.invalidLatitudeProvided)
        }

        guard let longitude = Double(longitude) else {
            throw(ValidationErrors.invalidLongitudeProvided)
        }

        let model = LocationDomainModel(name: name, latitude: latitude, longitude: longitude)
        repository.createCustomLocation(location: model)
    }
}
