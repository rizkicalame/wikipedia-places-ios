//
//  LocationsCache.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

/// Interface for cache implementations for custom locations.
protocol CustomLocationsCacheInterface: Actor {
    func getCustomLocations() -> [LocationDataModel]
    func addLocations(_ locations: [LocationDataModel])
    func clearCache()
}

actor CustomLocationsCache: CustomLocationsCacheInterface {

    // MARK: - Properties

    private var inMemoryLocations = [LocationDataModel]()

    // MARK: - LocationsCacheInterface

    /// Adds items in memory
    /// - Parameter items: The list of items to add.
    func addLocations(_ locations: [LocationDataModel]) {
        inMemoryLocations += locations
    }

    func getCustomLocations() -> [LocationDataModel] {
        return inMemoryLocations
    }

    /// Clears the cache indefinitely.
    func clearCache() {
        inMemoryLocations = []
    }
}

