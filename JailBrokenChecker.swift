//
//  JailBrokenChecker.swift
//  SameSystem
//
//  Created by Amr Elghadban on 11/15/17.
//  Copyright © 2017 Karmaadam . All rights reserved.
//

import Foundation
import UIKit

class JailBrokenChecker {
    
    /// getFirmware version
    ///
    /// - Returns: number of vesrion
    func firmwareVersion() -> Float {
        return Float((((UIDevice.current.systemVersion as NSString).substring(to: 3)) )) ?? 0.0
    }
    
    /// will check for most comman path for jailbroken devices
    ///
    /// - Parameter isCloseApp: to kill and close the application
    /// - Returns: true if applications is valide
    func isDeviceJailbroken(isCloseApp:Bool = true) -> Bool  {
        #if TARGET_IPHONE_SIMULATOR || arch(i386) || arch(x86_64)
            
            debugPrint("Simulator")
            
            return false
        #else
            //Apps and System check list
            var isDirectory: ObjCBool = ObjCBool(false)
            //var isDirectory: Bool = false
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("bla")\("ckra1n.a")\("pp")") || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("Fake")\("Carrier.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("Ic")\("y.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("Inte")\("lliScreen.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("MxT")\("ube.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("Roc")\("kApp.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("SBSet")\("ttings.a")\("pp")")
                || FileManager.default.fileExists(atPath: "/\("App")\("lic")\("ati")\("ons/")\("Wint")\("erBoard.a")\("pp")")
                
                || FileManager.default.fileExists(atPath: "/\("pr")\("iva")\("te/v")\("ar/l")\("ib/a")\("pt/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("pr")\("iva")\("te/v")\("ar/l")\("ib/c")\("ydia/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("pr")\("iva")\("te/v")\("ar/mobile")\("Library/SBSettings")\("Themes/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("pr")\("iva")\("te/v")\("ar/t")\("mp/cyd")\("ia.log")")
                || FileManager.default.fileExists(atPath: "/\("pr")\("iva")\("te/v")\("ar/s")\("tash/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("us")\("r/l")\("ibe")\("xe")\("c/cy")\("dia/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("us")\("r/b")\("in")\("s")\("shd")")
                || FileManager.default.fileExists(atPath: "/\("us")\("r/sb")\("in")\("s")\("shd")")
                || FileManager.default.fileExists(atPath: "/\("us")\("r/l")\("ibe")\("xe")\("c/cy")\("dia/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("us")\("r/l")\("ibe")\("xe")\("c/sftp-")\("server")")
                || FileManager.default.fileExists(atPath: "/\("/Syste")\("tem/Lib")\("rary/Lau")\("nchDae")\("mons/com.ike")\("y.bbot.plist")")
                || FileManager.default.fileExists(atPath: "/\("/Sy")\("stem/Lib")\("rary/Laun")\("chDae")\("mons/com.saur")\("ik.Cy")\("@dia.Star")\("tup.plist")")
                || FileManager.default.fileExists(atPath: "/\("/Libr")\("ary/Mo")\("bileSubstra")\("te/MobileSubs")\("trate.dylib")")
                || FileManager.default.fileExists(atPath: "/\("/va")\("r/c")\("ach")\("e/a")\("pt/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("/va")\("r/l")\("ib")\("/apt/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("/va")\("r/l")\("ib/c")\("ydia/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("/va")\("r/l")\("og/s")\("yslog")")
                || FileManager.default.fileExists(atPath: "/\("/bi")\("n/b")\("ash")")
                || FileManager.default.fileExists(atPath: "/\("/b")\("in/")\("sh")")
                || FileManager.default.fileExists(atPath: "/\("/et")\("c/a")\("pt/")", isDirectory: &isDirectory)
                || FileManager.default.fileExists(atPath: "/\("/etc/s")\("sh/s")\("shd_config")")
                || FileManager.default.fileExists(atPath: "/\("/us")\("r/li")\("bexe")\("c/ssh-k")\("eysign")"){
                
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
    
    /// detect if the application is installed form appstore
    ///
    /// - Parameter isCloseApp: to kill and close the application
    /// - Returns: true if applications is valide
    func isAppStoreVersion(isCloseApp:Bool = false) -> Bool {
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
    
    
    public static func jailbroken(application: UIApplication) -> Bool {
        guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return isJailbroken() }
        return application.canOpenURL(cydiaUrlScheme as URL) || isJailbroken()
    }
    
    
    
    static func isJailbroken() -> Bool {
        #if TARGET_IPHONE_SIMULATOR
            return false
        #else
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
                fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
                fileManager.fileExists(atPath: "/bin/bash") ||
                fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
                fileManager.fileExists(atPath: "/etc/apt") ||
                fileManager.fileExists(atPath: "/usr/bin/ssh") {
                return true
            }
            
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
    
    static func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }
    
    
    
    

    
}
