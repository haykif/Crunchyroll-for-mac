//
//  WebKitApp.swift
//  WebKit
//
//  Created by Hamza Aydoğdu on 22/04/2025.
//

import SwiftUI
import AppKit

@main
struct CrunchyrollApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var instructions: String {
        """
        🎬 Utiliser Crunchyroll Launcher
        Ouvre l’app, Safari lance crunchyroll.com.
        Quand tu fermes l’onglet, l’app se ferme toute seule.

        ⚙️ Vérifier
        Extension Safari activée dans
        Réglages > Extensions.
        Elle a l’autorisation d’agir sur
        crunchyroll.com.

        Cette app ouvre seulement Crunchyroll et détecte sa fermeture. C’est tout.

        🍿 Bon visionnage!
        """
    }
    
    var body: some Scene {
        MenuBarExtra {
            Group{
                Button("Crunchyroll Launcher") {
                    NSWorkspace.shared.open(URL(string: "https://www.crunchyroll.com")!)
                }
                
                Button("How to use Crunchyroll App") {
                    let helpAlert = NSAlert()
                    helpAlert.messageText = "Instructions"
                    helpAlert.informativeText = instructions
                    helpAlert.alertStyle = .informational
                    helpAlert.addButton(withTitle: "OK")
                    helpAlert.runModal()
                }
                
                Text("–––––––––––––––––––––––")
                
                Button("About Crunchyroll") {
                    NSApp.sendAction(#selector(AppDelegate.showAbout), to: nil, from: nil)
                }
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
        } label : {
            Image("crunchyroll-icon")
                .renderingMode(.template)
                .resizable()
                .frame(width: 18, height: 18)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("À propos de Crunchyroll") {
                    NSApp.sendAction(#selector(AppDelegate.showAbout), to: nil, from: nil)
                }
                .keyboardShortcut("i", modifiers: [.command])
                
                Button("Instructions") {
                    let instructionsAlert = NSAlert()
                    instructionsAlert.messageText = "How to use Crunchyroll App"
                    instructionsAlert.informativeText = instructions
                    instructionsAlert.runModal()
                }
                .keyboardShortcut(.init("m"), modifiers: [.command])
            }
            
            CommandMenu("Support") {
                Button("Contact Haykif") {
                    NSWorkspace.shared.open(URL(string: "mailto:h.aykif@caramail.com")!)
                }
                Button("Profile GitHub") {
                    NSWorkspace.shared.open(URL(string: "https://github.com/haykif")!)
                }
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var quitServer = QuitServer()

    func applicationDidFinishLaunching(_ notification: Notification) {
        if let url = URL(string: "https://www.crunchyroll.com") {
            NSWorkspace.shared.open(url)
        }

        // Lance le serveur d'écoute de fermeture Crunchyroll
        quitServer.start()
        
        NSApplication.shared.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func showAbout() {
        let alert = NSAlert()
        alert.messageText = "À propos de Crunchyroll"
        alert.informativeText = """
            Crunchyroll Launcher

            Cette application est un utilitaire tiers, conçu à des fins personnelles et strictement non commerciales.  
            Elle permet d’ouvrir automatiquement le site Crunchyroll® dans le navigateur Safari, puis de se fermer de manière autonome lorsque l’onglet Crunchyroll® est fermé.

            Aucune donnée personnelle n’est collectée, transmise ou stockée.  
            L’application n’interagit à aucun moment avec les services internes, comptes utilisateurs ou API de Crunchyroll®.

            https://www.crunchyroll.com/
        
            🛡️ Avis de non-affiliation :

            Crunchyroll Launcher est un projet totalement indépendant.  
            Il n’est en aucun cas affilié, sponsorisé, approuvé ou soutenu par Crunchyroll, LLC®, Sony Pictures Entertainment®, ou toute autre entité appartenant à Sony Group Corporation®.

            Il ne s’agit pas d’une application officielle. Son nom et ses fonctions ne doivent pas être interprétés comme une représentation ou une extension de Crunchyroll®.

            Toutes les marques citées, y compris Crunchyroll®, Sony® et leurs logos, sont la propriété exclusive de leurs titulaires respectifs.

        

            📜 Limitation de responsabilité :

            Cette application est fournie « telle quelle », sans aucune garantie, explicite ou implicite.  
            Son auteur décline toute responsabilité en cas de dommages directs, indirects, accessoires ou consécutifs liés à son usage, y compris toute perte de données, incompatibilité ou interruption de service.

            L’utilisateur accepte d’utiliser cette application sous sa seule et entière responsabilité.

            —

            © 2025 Haykif  
            Tous droits réservés sur l’application, son code source, et l’extension Safari.

        """
        alert.addButton(withTitle: "Compris")
        alert.runModal()
    }
}
