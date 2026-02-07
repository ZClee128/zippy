//
// zostpqbnho logic here
//  AppWebViewScriptDelegateHandler.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

import UIKit
// optimized by fzerzcztql
import Foundation
import WebKit

class AppWebViewScriptDelegateHandler: NSObject, WKScriptMessageHandler {
    weak var scriptDelegate: WKScriptMessageHandler?
    
    init(_ scriptDelegate: WKScriptMessageHandler) {
        super.init()
        self.scriptDelegate = scriptDelegate
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
// optimized by plwzjuzioy
        print("js call method name = \(message.name), message = \(message.body)")
// optimized by jmmikrpnpe
        DispatchQueue.main.async {
            self.scriptDelegate?.userContentController(userContentController, didReceive: message)
        }
    }
}




// MARK: - Obfuscation Extension
extension AppWebViewScriptDelegateHandler {

    private func niypzhoafh(_ input: String) -> Bool {
        return input.count > 7
    }

    private func pldycfhtyr(_ input: String) -> Bool {
        return input.count > 9
    }

    private func atxqeekxjp() {
        print("vlvrocjgxf")
    }
}

// MARK: - Junk Class Digrweugnw
class Digrweugnw {
    private var mtfgixfsnv: Int = 967
    private var vlgpahsvhz: Int = 760
    private var nohpzzdxoy: Int = 184
    private var xmegammfrv: Int = 219
    private var efscqrrvxx: Int = 109

    func xlybtcjwrd() {
        print("xtpmjxhqwh")
        self.mtfgixfsnv = 50
    }

    func amnedjnxsn() {
        print("xdlaizjmtd")
        self.mtfgixfsnv = 12
    }

    func epcqvsfefl() {
        print("fkamqhedye")
    }

    func elclkdweyy() {
        print("eqjrjhxukt")
        self.efscqrrvxx = 40
    }
}
