// Copyright © 2019 hipolabs. All rights reserved.

import Foundation
import Mixpanel

open class MixpanelAnalyticsService: AnalyticsService {
    public let config: Config

    /// <mark> Decodable
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let apiToken = try container.decodeIfPresent(String.self, forKey: .apiToken) ?? ""
        config = Config(apiToken: apiToken)

        initialize()
    }

    /// <mark> ExpressibleByNilLiteral
    public required init(nilLiteral: ()) {
        config = Config(apiToken: "")
    }

    open func register<T: AnalyticsTrackableUser>(user: T?, first: Bool) {
        let instance = Mixpanel.mainInstance()

        guard let user = user else {
            return
        }
        instance.identify(distinctId: user.id)
        instance.people.set(properties: user.mixpanel_analyticsMetadata)
        instance.registerSuperProperties(user.mixpanel_analyticsMetadata)
    }

    open func canTrack<T: AnalyticsTrackableScreen>(_ screen: T) -> Bool {
        return true
    }

    open func track<T: AnalyticsTrackableScreen>(_ screen: T) {
        Mixpanel.mainInstance().track(event: "Screen: \(screen.name)", properties: screen.mixpanel_analyticsMetadata)
    }

    open func canTrack<T: AnalyticsTrackableEvent>(_ event: T) -> Bool {
        return true
    }

    open func track<T: AnalyticsTrackableEvent>(_ event: T) {
        Mixpanel.mainInstance().track(event: "Event: \(event.type.description)", properties: event.mixpanel_analyticsMetadata)
    }

    open func unregisterUser() {
        Mixpanel.mainInstance().reset()
    }
}

extension MixpanelAnalyticsService {
    private func initialize() {
        if !config.isValid { return }

        Mixpanel.initialize(token: config.apiToken)

        debug {
            Mixpanel.mainInstance().loggingEnabled = true
        }
    }
}

extension MixpanelAnalyticsService {
    public enum CodingKeys: String, CodingKey {
        case apiToken = "api_token"
    }
}

extension MixpanelAnalyticsService {
    public struct Config {
        public let apiToken: String

        var isValid: Bool {
            return !apiToken.isEmpty
        }
    }
}
