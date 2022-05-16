//
//  SessionIdManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

class SessionIdManager {
    private var sessionID: String = ""

    static let sharedInstance = SessionIdManager()

    func getInstance() -> String {
        if self.sessionID.isEmpty {
            self.sessionID = UUID().uuidString
        }

        return self.sessionID
    }

    func generateNewInstance() -> String {
        self.sessionID = UUID().uuidString

        return self.sessionID
    }
}
