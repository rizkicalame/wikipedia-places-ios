//
//  DataModelInterface.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

/// An interface a data model should conform to.
/// A prerequisite is that a data model should always be mappable to a DomainModel
protocol DataModelInterface {
    associatedtype DomainModelType: DomainModelInterface

    func toDomainModel() -> DomainModelType
}
