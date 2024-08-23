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

    // MARK: - LocationsCacheInterface

    var inMemoryLocations: [LocationDataModel]

    func addItems(_ items: [LocationDataModel]) {
        inMemoryLocations += items
    }

    func clearCache() {
        inMemoryLocations = []
    }

    // MARK: - Init

    init() {
        self.inMemoryLocations = []
    }

    // MARK: - Internal


}

