//
//  SafariWebExtensionHandler.swift
//  CrunchyExtension
//
//  Created by Hamza Aydoğdu on 22/04/2025.
//

import SafariServices
import os.log

class SafariExtensionHandler: SFSafariExtensionHandler {
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // Quand l'utilisateur clique sur l'icône de l'extension
        window.getActiveTab { tab in
            tab?.navigate(to: URL(string: "https://www.crunchyroll.com")!)
        }
    }
}
