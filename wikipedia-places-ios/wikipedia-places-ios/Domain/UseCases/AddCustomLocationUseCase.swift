//
//  AddCustomLocationUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

protocol AddCustomLocationUseCaseInterface {
    func addCustomLocation(name: String?, latitude: String, longitude: String)
}

class AddCustomLocationUseCase: AddCustomLocationUseCaseInterface {

    // MARK: - Properties

    private let repository: LocationsRepositoryInterface

    // MARK: - Init

    init(repository: LocationsRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - AddCustomLocationUseCaseInterface

    func addCustomLocation(name: String?, latitude: String, longitude: String) {
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return
        }

        // TODO: Formatting and validation
        let model = LocationDomainModel(name: name, latitude: latitude, longitude: longitude)
        repository.createCustomLocation(location: model)
    }
}
