//
//  RushApp.swift
//  Rush
//
//  Created by Michael Gillund on 10/4/22.
//

import SwiftUI

@main
struct RushApp: App {
    
    @StateObject
    private var model = ViewModel()
    
//    init(){
//        for family in UIFont.familyNames {
//            print("\(family)")
//
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("   \(name)")
//            }
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
