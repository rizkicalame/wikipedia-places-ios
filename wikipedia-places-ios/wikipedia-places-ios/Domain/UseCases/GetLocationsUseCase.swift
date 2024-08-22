//
//  GetLocationsUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

protocol GetLocationsUseCaseInterface {
    func getLocations() async throws -> [LocationDomainModel]
}

final class GetLocationsUseCase: GetLocationsUseCaseInterface {

    private let repository: LocationsRepositoryInterface

    init(repository: LocationsRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - GetLocationsUseCaseInterface

    func getLocations() async throws -> [LocationDomainModel] {
        return try await repository.getLocations()
    }
}
