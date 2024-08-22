//
//  LocationDataModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

struct LocationDataModel: DataModelInterface, Decodable {

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }

    // MARK: - Properties

    let name: String?
    let latitude: Double
    let longitude: Double
}

extension LocationDataModel {
    func toDomainModel() -> LocationDomainModel {
        LocationDomainModel(name: name,
                            latitude: latitude,
                            longitude: longitude)
    }
}
