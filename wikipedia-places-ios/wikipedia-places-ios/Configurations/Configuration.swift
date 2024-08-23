//
//  Configuration.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

enum Configuration {
    enum Keys: String {
        case apiURL = "API_URL"
    }

    /// Tries to find a specific key in the environment configuration. See the `Configurations` folder
    /// Will result in fatalErrors if the key was not found or the value was not specified as a string.
    /// - Parameter key: The key of the value requested.
    /// - Returns: Value defined in the config.
    static func value(for key: Keys) -> String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            fatalError("Tried to find key: \(key) from environment, but not found")
        }

        switch object {
        case let value as String:
            return value
        default:
            fatalError("Tried to find value for: \(key) from environment, but value was invalid.")
        }
    }
}
