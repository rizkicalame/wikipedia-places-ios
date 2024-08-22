//
//  DomainModelInterface.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

protocol DomainModelInterface {
    associatedtype DataModelType: DataModelInterface

    func toDataModel() -> DataModelType
}
