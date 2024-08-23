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
    private let customLocationsCache: CustomLocationsCacheInterface

    // MARK: - Init

    init(apiClient: APIClientInterface,
         customLocationsCache: CustomLocationsCacheInterface = CustomLocationsCache.shared) {
        self.apiClient = apiClient
        self.customLocationsCache = customLocationsCache
    }

    // MARK: - LocationsRepositoryInterface

    func getLocations() async throws -> [LocationDomainModel] {
        let dataModels: [LocationDataModel] = try await apiClient.performRequest(path:
                                                                                    "/abnamrocoesd/assignment-ios/main/locations.json",
                                                                                 method: .get,
                                                                                 keyPath: "locations")

        let remoteLocations = dataModels.map {
            $0.toDomainModel()
        }

        let customLocations = customLocationsCache.inMemoryLocations.map {
            $0.toDomainModel()
        }

        return remoteLocations + customLocations
    }

    func createCustomLocation(location: LocationDomainModel) {
        let dataModel = location.toDataModel()
        customLocationsCache.addItems([dataModel])
    }
}
