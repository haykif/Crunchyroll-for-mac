//
//  QuitServer.swift
//  WebKit
//
//  Created by Hamza Aydoğdu on 22/04/2025.
//

import SwiftUI
import Foundation
import Network

class QuitServer {
    private var listener: NWListener?

    func start() {
        do {
            let parameters = NWParameters.tcp
            listener = try NWListener(using: parameters, on: 5555)

            listener?.newConnectionHandler = { connection in
                connection.start(queue: .main)
                connection.receive(minimumIncompleteLength: 1, maximumLength: 1024) { data, _, _, _ in
                    if let data = data,
                       let request = String(data: data, encoding: .utf8),
                       request.contains("GET /quit") {
                        print("Reçu signal de fermeture → Crunchyroll terminé.")
                        NSApplication.shared.terminate(nil)
                    }
                }
            }

            listener?.start(queue: .main)
            print("🟢 Serveur actif sur localhost:5555")
        } catch {
            print("❌ Erreur serveur : \(error)")
        }
    }
}
