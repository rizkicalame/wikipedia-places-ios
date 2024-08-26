//
//  LocationsCache.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

final class CustomLocationsCache: CustomLocationsCacheInterface {

    // MARK: - Shared

    static var shared: CustomLocationsCacheInterface = CustomLocationsCache()

    // MARK: - Init

    init() {
        self.inMemoryLocations = []
    }

    // MARK: - LocationsCacheInterface

    private(set) var inMemoryLocations: [LocationDataModel]

    /// Adds items in memory
    /// - Parameter items: The list of items to add.
    func addItems(_ items: [LocationDataModel]) {
        inMemoryLocations += items
    }

    /// Clears the cache indefinitely.
    func clearCache() {
        inMemoryLocations = []
    }
}

