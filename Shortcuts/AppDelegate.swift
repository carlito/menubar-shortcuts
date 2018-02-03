//
//  AppDelegate.swift
//  Shortcuts
//
//  Created by Carlos Stockhausen on 03.02.18.
//  Copyright © 2018 Carlos Stockhausen. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
        
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func hideDesktopIcons(_ sender: Any?) {
        
        @discardableResult
        func shell(_ args: String...) -> Int32 {
            let task = Process()
            task.launchPath = "/usr/bin/defaults"
            task.arguments = ["write", "com.apple.finder", "CreateDesktop", "false"]
            task.launch()
            task.waitUntilExit()
            return task.terminationStatus
        }
        
        shell("iconshide")
        
        restartFinder()
    }
    
    @objc func showDesktopIcons(_ sender: Any?) {
        
        @discardableResult
        func shell(_ args: String...) -> Int32 {
            let task = Process()
            task.launchPath = "/usr/bin/defaults"
            task.arguments = ["write", "com.apple.finder", "CreateDesktop", "true"]
            task.launch()
            task.waitUntilExit()
            return task.terminationStatus
        }
        
        shell("iconsshow")
        restartFinder()
    }
    
    func restartFinder() {
        let killTask = Process()
        killTask.launchPath = "/usr/bin/killall"
        killTask.arguments = ["Finder"]
        killTask.launch()
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Hide Desktop Icons", action: #selector(AppDelegate.hideDesktopIcons(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Show Desktop Icons", action: #selector(AppDelegate.showDesktopIcons(_:)), keyEquivalent: ""))
        
        statusItem.menu = menu
    }

}



