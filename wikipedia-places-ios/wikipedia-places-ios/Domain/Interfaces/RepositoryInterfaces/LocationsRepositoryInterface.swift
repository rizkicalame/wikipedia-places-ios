//
//  LocationsRepositoryInterface.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

/// Interface for location repository implementations.
protocol LocationsRepositoryInterface {
    func getLocations() async throws -> [LocationDomainModel]
    func createCustomLocation(location: LocationDomainModel)
}
