//
//  GetLocationsUseCase.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

/// Interface for implementations of this use case.
protocol GetLocationsUseCaseInterface {
    func getLocations() async throws -> [LocationDomainModel]
}

final class GetLocationsUseCase: GetLocationsUseCaseInterface {

    // MARK: - Properties

    private let repository: LocationsRepositoryInterface

    // MARK: - Init

    init(repository: LocationsRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - GetLocationsUseCaseInterface
    
    /// Fetches the locations from the repository.
    /// - Returns: A list of location domain models.
    func getLocations() async throws -> [LocationDomainModel] {
        return try await repository.getLocations()
    }
}
