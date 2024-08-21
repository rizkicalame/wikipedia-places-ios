import Foundation

// MARK: Common

public enum WMFDataControllerError: LocalizedError {
    case mediaWikiServiceUnavailable
    case basicServiceUnavailable
    case failureCreatingRequestURL
    case unexpectedResponse
    case serviceError(Error)
    case mediaWikiResponseError(WMFMediaWikiError)
    case paymentsWikiResponseError(String?)
}

public enum WMFServiceError: Error, Equatable {
    case invalidRequest
    case invalidHttpResponse(Int?)
    case missingData
    case invalidResponseVersion
    case unexpectedResponse
}

public enum WMFUserDefaultsStoreError: Error {
    case unexpectedType
    case failureDecodingJSON(Error)
    case failureEncodingJSON(Error)
}

public enum WMFDonateDataControllerError: LocalizedError {
    case paymentsWikiResponseError(reason: String?, orderID: String?)
    
    public var errorDescription: String? {
        switch self {
        case .paymentsWikiResponseError(let reason, _):
            return reason
        }
    }
}
