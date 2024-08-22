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

    // MARK: - GetLocationsUseCaseInterface

    func getLocations() async throws -> [LocationDomainModel] {
        return [LocationDomainModel(name: "Test", latitude: 52.3547498, longitude: 4.8339215)]
    }
}
