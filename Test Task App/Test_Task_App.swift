//
//  Test_Task_AppApp.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import SwiftUI

@main
struct Test_TaskApp: App {
    @StateObject var newWorkerData = NewWorkerModel()
    var body: some Scene {
        WindowGroup {
            UITabBarController()
                .environmentObject(newWorkerData)
        }
    }
}
