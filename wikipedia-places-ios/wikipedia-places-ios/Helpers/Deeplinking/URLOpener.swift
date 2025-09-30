//
//  URLOpener.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import UIKit

protocol URLOpening {
    @MainActor
    func canOpenURL(_ url: URL) -> Bool

    @MainActor
    func openURL(_ url: URL) async -> Bool
}

struct URLOpener: URLOpening {
    func canOpenURL(_ url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }

    func openURL(_ url: URL) async -> Bool {
        await UIApplication.shared.open(url)
    }
}
