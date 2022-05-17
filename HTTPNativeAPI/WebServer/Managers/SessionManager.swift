//
//  SessionManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

class SessionManager {
    private var sessionID: String = ""

    static let sharedInstance = SessionManager()

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
