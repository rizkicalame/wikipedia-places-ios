//
//  APIClient.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import Foundation

// MARK: - Methods

enum HTTPMethod: String {
    case get, put, post, delete
}

// MARK: - Interface

protocol APIClientInterface {
    func performRequest<DataModel: Decodable>(path: String,
                                              method: HTTPMethod,
                                              keyPath: String?) async throws -> DataModel
}

final class APIClient: APIClientInterface {

    // MARK: - APIError

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case decodingFailed(Error)
    }

    // MARK: - Properties

    private let baseURL: String
    private let session: URLSession

    // MARK: - Init

    /// Initialiser for the APIClient.
    /// - Parameters:
    ///   - baseURL: The baseURL for the server this APIClient connects to.
    ///   - session: URLSession to be used during information exchange with the server. Will default back to the `.shared` session if non specified.
    init(baseURL: String,
         session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }

    // MARK: - Internal

    /// Performs a request to an API using the specified path, method, keyPath and decodableObject.
    /// - Parameters:
    ///   - path: The path to the endpoint that needs to be called.
    ///   - method: The HTTP method to be used for the request. Defaults back to `GET`
    ///   - keyPath: Optional keyPath value. Used to specify an object to decode. E.g. the response is an object containing one property `locations`, which is an array of objects you'd like to decode.
    ///   Will throw an error if anything in regards to validation, request status or decoding has failed.
    /// - Returns: The requested data model.
    func performRequest<DataModel: Decodable>(path: String,
                                              method: HTTPMethod = .get,
                                              keyPath: String? = nil) async throws -> DataModel {
        guard let fullURL = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue

        return try await performRequest(request: request,
                                        keyPath: keyPath)
    }

    // MARK: - Private

    /// Performs the request.
    /// - Parameters:
    ///   - request: The request that needs to be made.
    ///   - keyPath: The keyPath to decode from.
    /// - Returns: The model to decode to.
    private func performRequest<DataModel: Decodable>(request: URLRequest,
                                                      keyPath: String?) async throws -> DataModel {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard validateResponse(response: response) else {
            throw APIError.invalidResponse
        }

        return try decodeResponse(data: data, keyPath: keyPath)
    }

    /// Validates the response based on the HTTP code.
    /// Anything in range of 200 to 299 is considered succesful.
    /// - Parameter response: The URLResponse object to validate.
    /// - Returns: Boolean value whether or not the response was successful
    private func validateResponse(response: URLResponse) -> Bool {
        let successfulStatusCodes = (200...299)

        guard
            let httpResponse = response as? HTTPURLResponse,
            successfulStatusCodes.contains(httpResponse.statusCode) else {
            return false
        }

        return true
    }

    /// Decodes the data received by the server.
    /// - Parameters:
    ///   - data: The data received from the server
    ///   - keyPath: The keyPath to decode from. Optional. Will attempt decode the entire data set if none specified.
    ///   Will throw errors if decoding has failed.
    /// - Returns: The model to decode to.
    private func decodeResponse<DataModel: Decodable>(data: Data,
                                                      keyPath: String?) throws -> DataModel {
        do {
            let jsonDecoder = JSONDecoder()

            // If a keyPath for decoding was specified
            if let keyPath {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                // Find the object using the keyPath
                guard let keyObject = (json as AnyObject).value(forKeyPath: keyPath) else {
                    let error = NSError(domain: "InvalidDecodingKeyPathSpecified", code: -1, userInfo: nil)
                    throw APIError.decodingFailed(error)
                }

                // Decode the key object
                let keyData = try JSONSerialization.data(withJSONObject: keyObject, options: [])
                return try jsonDecoder.decode(DataModel.self, from: keyData)
            } else {
                return try jsonDecoder.decode(DataModel.self, from: data)
            }
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
