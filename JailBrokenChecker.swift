//
//  JailBrokenChecker.swift
//  
//
//  Created by Amr Elghadban on 11/15/17.
//  Copyright © 2017 Karmaadam . All rights reserved.
//

import Foundation
import UIKit

class JailBrokenChecker {
    
    /// getFirmware version
    ///
    /// - Returns: number of version
    public static func firmwareVersion() -> Float {
        return Float((((UIDevice.current.systemVersion as NSString).substring(to: 3)) )) ?? 0.0
    }
    
    /// will check for most comman path for jailbroken devices
    ///
    /// - Parameter isCloseApp: to kill and close the application
    /// - Returns: true if applications is validated
    public static func isDeviceJailbroken(_ isCloseApp:Bool = true) -> Bool  {
        #if TARGET_IPHONE_SIMULATOR || arch(i386) || arch(x86_64)
            
            debugPrint("Simulator")
            
            return false
        #else
            //Apps and System check list
            var isDirectory: ObjCBool = ObjCBool(false)
            //var isDirectory: Bool = false
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Applications/blackra1n.app")
                || FileManager.default.fileExists(atPath: "/Applications/FakeCarrier.app")
                || FileManager.default.fileExists(atPath: "/Applications/Icy.app")
                || FileManager.default.fileExists(atPath: "/Applications/IntelliScreen.app")
                || FileManager.default.fileExists(atPath: "/Applications/MxTube.app")
                || FileManager.default.fileExists(atPath: "/Applications/RockApp.app")
                || FileManager.default.fileExists(atPath: "/Applications/SBSetttings.app")
                || FileManager.default.fileExists(atPath: "/Applications/WinterBoard.app")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/)", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/private/var/lib/cydia/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/private/var/mobileLibrary/SBSettingsThemes/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/private/var/tmp/cydia.log")
                || FileManager.default.fileExists(atPath: "/private/var/stash/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/usr/libexe\("c/cy")\("dia/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/usr/binsshd")
                || FileManager.default.fileExists(atPath: "/usr/sbinsshd")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/usr/bin/ssh")
                || FileManager.default.fileExists(atPath: "/usr/libexec/cydia/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/usr/libexec/sftp-server")
                || FileManager.default.fileExists(atPath: "/usr/libexec/ssh-keysign")
                || FileManager.default.fileExists(atPath: "/Systetem/Library/LaunchDaemons/com.ikey.bbot.plist")
                || FileManager.default.fileExists(atPath: "/System/Library/LaunchDaemons/com.saurik.Cy@dia.Startup.plist")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/var/cache/apt/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/var/libapt/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/var/lib/cydia/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/var/log/syslog")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/bin/sh")
                || FileManager.default.fileExists(atPath: "/etc/apt/", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/etc/ssh/sshd_config"){
                
                debugPrint("Jailbroken Device")
                
                if isCloseApp{
                    exit(0)
                }
                return true
                
            }
        
            //Try to write file in private
            let error: Error?
            try? "Jailbreak test string".write(toFile: "/private/test_jb.txt", atomically: true, encoding: .utf8)
            if nil == error {
                //Wrote?: JB device
                //cleanup what you wrote
                try? FileManager.default.removeItem(atPath: "/private/test_jb.txt")
                
                debugPrint("Jailbroken Device")
                
                if isCloseApp{
                    exit(0)
                }
                return true
            }
            
            if Bundle.main.infoDictionary?["SignerIdentity"] != nil {
                debugPrint("Jailbroken Device")
                if isCloseApp{
                    exit(0)
                }
                return true
            }else{
                debugPrint("Clean Device")
                return false
            }
            
            return isAppStoreVersion(isCloseApp)
            
        #endif
        
    }
    
    /// detect if the application is installed from AppStore
    ///
    /// - Parameter isCloseApp: to kill and close the application
    /// - Returns: true if applications is validated
    public static func isAppStoreVersion(isCloseApp:Bool = false) -> Bool {
        #if TARGET_IPHONE_SIMULATOR || arch(i386) || arch(x86_64)
            return false
        #else
            let provisionPath: String? = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision")
            if nil == provisionPath || 0 == (provisionPath?.count ?? 0) {
                debugPrint("Jailbroken Device")
                if isCloseApp{
                    exit(0)
                }
                return true
            }
            debugPrint("Clean Device")
            return false
        #endif
    }
    
    fileprivate func jailbroken(application: UIApplication) -> Bool {
        guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return isJailbroken() }
        return application.canOpenURL(cydiaUrlScheme as URL) || isJailbroken()
    }

    fileprivate func isJailbroken() -> Bool {
        #if TARGET_IPHONE_SIMULATOR
            return false
        #else
            let fileManager = FileManager.default
        
            if canOpen(path: "/Applications/Cydia.app") ||
                canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
                canOpen(path: "/bin/bash") ||
                canOpen(path: "/usr/sbin/sshd") ||
                canOpen(path: "/etc/apt") ||
                canOpen(path: "/usr/bin/ssh") {
                return true
            }
            
            let path = "/private/" + NSUUID().uuidString
            do {
                try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                try fileManager.removeItem(atPath: path)
                return true
            } catch {
                return false
            }
        #endif
    }
    
    fileprivate func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }

}
