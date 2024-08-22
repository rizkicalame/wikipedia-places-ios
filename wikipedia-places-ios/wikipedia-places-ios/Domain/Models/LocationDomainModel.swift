//
//  LocationDomainModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

struct LocationDomainModel: DomainModelInterface, Identifiable {

    // MARK: - Identifiable
    
    let id = UUID()

    // MARK: - Properties

    let name: String?
    let latitude: Double
    let longitude: Double

    // MARK: - Computed

    var presentedName: String {
        name ?? "No name provided"
    }

    var presentedCoordinates: String {
        "\(latitude ), \(longitude)"
    }

    // MARK: - DomainModelInterface

    func toDataModel() -> LocationDataModel {
        LocationDataModel(name: name, 
                          latitude: latitude,
                          longitude: longitude)
    }
}
