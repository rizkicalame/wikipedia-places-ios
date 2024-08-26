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

    /// Fetches the locations from both the remote server as well as the custom locations cache if any are present there.
    /// - Returns: A list of location domain models.
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
    
    /// Creates a custom location and adds it to the cache. Preserved in memory alone.
    /// - Parameter location: The domain model representation of a location,
    func createCustomLocation(location: LocationDomainModel) {
        let dataModel = location.toDataModel()
        customLocationsCache.addItems([dataModel])
    }
}
