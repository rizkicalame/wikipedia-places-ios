//
//  Configuration.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value(for key: String) throws -> String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as String:
            return value
        default:
            throw Error.invalidValue
        }
    }
}
