//
//  LocationsRepository.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

final class LocationsRepository: LocationsRepositoryInterface {

    // MARK: - Properties

    private let apiClient: APIClientInterface
    private var customLocations = [LocationDataModel]()

    // MARK: - Init

    init(apiClient: APIClientInterface) {
        self.apiClient = apiClient
    }

    // MARK: - LocationsRepositoryInterface

    func getLocations() async throws -> [LocationDomainModel] {
        let dataModels: [LocationDataModel] = try await apiClient.performRequest(path:
                                                                                    "/abnamrocoesd/assignment-ios/main/locations.json",
                                                                                 method: .get,
                                                                                 keyPath: "locations")
        return dataModels.map {
            $0.toDomainModel()
        }
    }

    func createCustomLocation(location: LocationDomainModel) {
        let dataModel = location.toDataModel()
        customLocations.append(dataModel)
    }
}
