import Foundation
import UIKit

public final class WMFAltTextDataController {
    
    struct OnboardingStatus: Codable {
        var hasPresentedOnboardingModal: Bool

        static var `default`: OnboardingStatus {
            return OnboardingStatus(hasPresentedOnboardingModal: false)
        }
    }
    
    public static let shared = WMFAltTextDataController()
    
    public lazy var experimentStopDate: Date? = {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 10
        dateComponents.day = 21
        return Calendar.current.date(from: dateComponents)
    }()
    
    public enum WMFAltTextDataControllerError: Error {
        case featureFlagIsOff
        case notLoggedIn
        case invalidProject
        case invalidDeviceOrOS
        case invalidDate
        case unexpectedBucketValue
        case alreadyAssignedThisExperiment
        case alreadyAssignedOtherExperiment
    }
    
    private let experimentsDataController: WMFExperimentsDataController
    private let developerSettingsDataController: WMFDeveloperSettingsDataController
    private let userDefaultsStore: WMFKeyValueStore
    private var experimentPercentage: Int {
        developerSettingsDataController.alwaysShowAltTextEntryPoint ? 100 : 50
    }
    
    // MARK: - Public
    
    public init?(experimentStore: WMFKeyValueStore? = WMFDataEnvironment.current.sharedCacheStore, userDefaultsStore: WMFKeyValueStore? = WMFDataEnvironment.current.userDefaultsStore) {
        
        guard let experimentStore,
        let userDefaultsStore else {
            return nil
        }
        
        self.experimentsDataController = WMFExperimentsDataController(store: experimentStore)
        self.developerSettingsDataController = WMFDeveloperSettingsDataController.shared
        self.userDefaultsStore = userDefaultsStore
    }
    
    public func assignImageRecsExperiment(isLoggedIn: Bool, project: WMFProject) throws {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            throw WMFAltTextDataControllerError.featureFlagIsOff
        }
        
        guard isLoggedIn else {
            throw WMFAltTextDataControllerError.notLoggedIn
        }
        
        guard project.qualifiesForAltTextExperiments(developerSettingsDataController: developerSettingsDataController) else {
            throw WMFAltTextDataControllerError.invalidProject
        }
        
        guard isValidDeviceAndOS else {
            throw WMFAltTextDataControllerError.invalidDeviceOrOS
        }
        
        guard isBeforeEndDate else {
            throw WMFAltTextDataControllerError.invalidDate
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            if experimentsDataController.bucketForExperiment(.altTextImageRecommendations) != nil {
                throw WMFAltTextDataControllerError.alreadyAssignedThisExperiment
            }
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            if let articleEditorExperimentBucket = experimentsDataController.bucketForExperiment(.altTextArticleEditor) {
                
                switch articleEditorExperimentBucket {
                case .altTextArticleEditorTest:
                    throw WMFAltTextDataControllerError.alreadyAssignedOtherExperiment
                case .altTextArticleEditorControl:
                    break
                default:
                    throw WMFAltTextDataControllerError.unexpectedBucketValue
                }
            }
        }
        
        try experimentsDataController.determineBucketForExperiment(.altTextImageRecommendations, withPercentage: experimentPercentage)
        
    }
    
    public func assignArticleEditorExperiment(isLoggedIn: Bool, project: WMFProject) throws {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            throw WMFAltTextDataControllerError.featureFlagIsOff
        }
        
        guard isLoggedIn else {
            throw WMFAltTextDataControllerError.notLoggedIn
        }
        
        guard project.qualifiesForAltTextExperiments(developerSettingsDataController: developerSettingsDataController) else {
            throw WMFAltTextDataControllerError.invalidProject
        }
        
        guard isValidDeviceAndOS else {
            throw WMFAltTextDataControllerError.invalidDeviceOrOS
        }
        
        guard isBeforeEndDate else {
            throw WMFAltTextDataControllerError.invalidDate
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            if experimentsDataController.bucketForExperiment(.altTextArticleEditor) != nil {
                throw WMFAltTextDataControllerError.alreadyAssignedThisExperiment
            }
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            if let imageRecommendationsExperimentBucket = experimentsDataController.bucketForExperiment(.altTextImageRecommendations) {
                
                switch imageRecommendationsExperimentBucket {
                case .altTextImageRecommendationsTest:
                    throw WMFAltTextDataControllerError.alreadyAssignedOtherExperiment
                case .altTextImageRecommendationsControl:
                    break
                default:
                    throw WMFAltTextDataControllerError.unexpectedBucketValue
                }
            }
        }
        
        try experimentsDataController.determineBucketForExperiment(.altTextArticleEditor, withPercentage: experimentPercentage)
    }
    
    public func markSawAltTextImageRecommendationsPrompt() {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            return
        }
        
        self.sawAltTextImageRecommendationsPrompt = true
    }
    
    public func shouldEnterAltTextImageRecommendationsFlow(isLoggedIn: Bool, project: WMFProject) -> Bool {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            return false
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            guard sawAltTextImageRecommendationsPrompt == false && sawAltTextArticleEditorPrompt == false else {
                return false
            }
        }
        
        guard isLoggedIn else {
            return false
        }
        
        guard project.qualifiesForAltTextExperiments(developerSettingsDataController: developerSettingsDataController) else {
            return false
        }
        
        guard isValidDeviceAndOS else {
            return false
        }
        
        guard isBeforeEndDate else {
            return false
        }
        
        guard let imageRecommendationsExperimentBucket = experimentsDataController.bucketForExperiment(.altTextImageRecommendations) else {
            return false
        }
            
        switch imageRecommendationsExperimentBucket {
        case .altTextImageRecommendationsTest:
            return true
        default:
            return false
        }
    }
    
    public func markSawAltTextArticleEditorPrompt() {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            return
        }
        
        self.sawAltTextArticleEditorPrompt = true
    }
    
    public func shouldFetchFullArticleWikitextFromArticleEditor(isLoggedIn: Bool, project: WMFProject) -> Bool {
        
        // feature flag enabled
        guard developerSettingsDataController.enableAltTextExperiment else {
            return false
        }
        
        // haven't already seen the prompt elsewhere
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            guard sawAltTextImageRecommendationsPrompt == false && sawAltTextArticleEditorPrompt == false else {
                return false
            }
        }
        
        // is logged in
        guard isLoggedIn else {
            return false
        }
        
        // is looking at the target experiment wikis
        guard project.qualifiesForAltTextExperiments(developerSettingsDataController: developerSettingsDataController) else {
            return false
        }
        
        // iPhone, iOS 16+
        guard isValidDeviceAndOS else {
            return false
        }
        
        // Before Oct 10
        guard isBeforeEndDate else {
            return false
        }
        
        // Hasn't already been assigned the alt text editor experiment
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            guard experimentsDataController.bucketForExperiment(.altTextArticleEditor) == nil else {
                return false
            }
        }
        
        return true
    }
    
    public func shouldEnterAltTextArticleEditorFlow(isLoggedIn: Bool, project: WMFProject) -> Bool {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            return false
        }
        
        if !developerSettingsDataController.alwaysShowAltTextEntryPoint {
            guard sawAltTextImageRecommendationsPrompt == false && sawAltTextArticleEditorPrompt == false else {
                return false
            }
        }
        
        guard isLoggedIn else {
            return false
        }
        
        guard project.qualifiesForAltTextExperiments(developerSettingsDataController: developerSettingsDataController) else {
            return false
        }
        
        guard isValidDeviceAndOS else {
            return false
        }
        
        guard isBeforeEndDate else {
            return false
        }
        
        guard let articleEditorExperimentBucket = experimentsDataController.bucketForExperiment(.altTextArticleEditor) else {
            return false
        }
            
        switch articleEditorExperimentBucket {
        case .altTextArticleEditorTest:
            return true
        default:
            return false
        }
    }
    
    public func assignedAltTextImageRecommendationsGroupForLogging() -> String? {
        
        guard developerSettingsDataController.enableAltTextExperiment else {
            return nil
        }
        
        if let imageRecommendationsExperimentBucket = experimentsDataController.bucketForExperiment(.altTextImageRecommendations) {
            switch imageRecommendationsExperimentBucket {
            case .altTextImageRecommendationsTest:
                return "B"
            case .altTextImageRecommendationsControl:
                return "A"
            default:
                break
            }
        }
        
        return nil
    }
    
    public func assignedAltTextArticleEditorGroupForLogging() -> String? {
        if let articleEditorExperimentBucket = experimentsDataController.bucketForExperiment(.altTextArticleEditor) {
            switch articleEditorExperimentBucket {
            case .altTextArticleEditorTest:
                return "C"
            case .altTextArticleEditorControl:
                return "D"
            default:
                break
            }
        }
        
        return nil
    }
    
    // MARK: - Onboarding
    
    private var onboardingStatus: OnboardingStatus {
        return (try? userDefaultsStore.load(key: WMFUserDefaultsKey.altTextExperimentOnboarding.rawValue)) ?? OnboardingStatus.default
    }

    public var hasPresentedOnboardingModal: Bool {
        get {
            return onboardingStatus.hasPresentedOnboardingModal
        } set {
            var currentOnboardingStatus = onboardingStatus
            currentOnboardingStatus.hasPresentedOnboardingModal = newValue
            try? userDefaultsStore.save(key: WMFUserDefaultsKey.altTextExperimentOnboarding.rawValue, value: currentOnboardingStatus)
        }
    }
    
    // MARK: - Private
    
    private var isValidDeviceAndOS: Bool {
        if #available(iOS 16, *) {
            return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        } else {
            return false
        }
    }
    
    private var isBeforeEndDate: Bool {
        
        guard let experimentStopDate else {
            return false
        }
        
        return experimentStopDate >= Date()
    }
    
    private var sawAltTextImageRecommendationsPrompt: Bool {
        get {
            return (try? userDefaultsStore.load(key: WMFUserDefaultsKey.sawAltTextImageRecommendationsPrompt.rawValue)) ?? false
        } set {
            try? userDefaultsStore.save(key: WMFUserDefaultsKey.sawAltTextImageRecommendationsPrompt.rawValue, value: newValue)
        }
    }
    
    private var sawAltTextArticleEditorPrompt: Bool {
        get {
            return (try? userDefaultsStore.load(key: WMFUserDefaultsKey.sawAltTextArticleEditorPrompt.rawValue)) ?? false
        } set {
            try? userDefaultsStore.save(key: WMFUserDefaultsKey.sawAltTextArticleEditorPrompt.rawValue, value: newValue)
        }
    }
    
}

private extension WMFProject {
    func qualifiesForAltTextExperiments(developerSettingsDataController: WMFDeveloperSettingsDataController) -> Bool {
        switch self {
        case .wikipedia(let language):
            switch language.languageCode {
            case "es", "fr", "pt", "zh", "test":
                return true
            case "en":
                return developerSettingsDataController.enableAltTextExperimentForEN
            default:
                return false
            }
        default:
            return false
        }
    }
}
