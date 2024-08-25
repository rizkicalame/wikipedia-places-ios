//
//  AddCustomLocationUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

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
