//
// TwilioVoIPImpl.swift
// AptoSDK
//
// Created by Takeichi Kanzaki on 17/06/2019.
//

import AptoSDK
import TwilioVoice

public class TwilioVoIPClient: NSObject, VoIPCallProtocol {
    private var call: TVOCall?
    private var startedAt: Date?
    private var callback: Result<Void, NSError>.Callback?

    public var isMuted: Bool {
        get {
            guard let call = call else { return false }
            return call.isMuted
        }
        set(newValue) {
            call?.isMuted = newValue
        }
    }

    public var isOnHold: Bool {
        get {
            guard let call = call else { return false }
            return call.isOnHold
        }
        set(newValue) {
            call?.isOnHold = newValue
        }
    }

    public var timeElapsed: TimeInterval {
        guard let date = startedAt else { return 0 }
        return Date().timeIntervalSince(date)
    }

    public func call(_ destination: VoIPToken, callback: @escaping Result<Void, NSError>.Callback) {
        self.callback = callback
        let connectOptions = TVOConnectOptions(accessToken: destination.accessToken) { builder in
            builder.params = ["request_token": destination.requestToken]
        }
        call = TwilioVoice.connect(with: connectOptions, delegate: self)
    }

    public func sendDigits(_ digits: VoIPDigits) {
        call?.sendDigits(digits.digits)
    }

    public func disconnect() {
        call?.disconnect()
        call = nil
    }
}

extension TwilioVoIPClient: TVOCallDelegate {
    public func callDidConnect(_ call: TVOCall) {
        self.call = call
        startedAt = Date()
        callback?(.success(()))
        callback = nil
    }

    public func call(_: TVOCall, didFailToConnectWithError error: Error) {
        call = nil
        callback?(.failure(error as NSError))
        callback = nil
    }

    public func call(_: TVOCall, didDisconnectWithError error: Error?) {
        call = nil
        if let error = error as NSError? {
            callback?(.failure(error))
            callback = nil
        }
    }
}
