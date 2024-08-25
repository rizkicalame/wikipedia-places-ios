//
//  LocationsCacheInterface.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

protocol CustomLocationsCacheInterface {
    static var shared: CustomLocationsCacheInterface { get }
    var inMemoryLocations: [LocationDataModel] { get }

    func addItems(_ items: [LocationDataModel])
    func clearCache()
}
