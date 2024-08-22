//
//  AddCustomLocationUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

protocol AddCustomLocationUseCaseInterface {
    func addCustomLocation(name: String?, latitude: Double, longitude: Double)
}

class AddCustomLocationUseCase: AddCustomLocationUseCaseInterface {

    // MARK: - Properties

    private let repository: LocationsRepositoryInterface

    // MARK: - Init

    init(repository: LocationsRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - AddCustomLocationUseCaseInterface

    func addCustomLocation(name: String?, latitude: Double, longitude: Double) {
        let model = LocationDomainModel(name: name, latitude: latitude, longitude: longitude)
        repository.createCustomLocation(location: model)
    }
}
