//
//  cenfotec_gramApp.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/9/21.
//

import SwiftUI
import Firebase

@main
struct cenfotec_gramApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(UserSession())
        }
    }
}


class AppDelegate: NSObject , UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
