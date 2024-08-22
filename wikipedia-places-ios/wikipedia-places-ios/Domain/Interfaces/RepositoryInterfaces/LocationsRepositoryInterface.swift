//
//  LocationsRepositoryInterface.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

protocol LocationsRepositoryInterface {
    func getLocations() async throws -> [LocationDomainModel]
}
