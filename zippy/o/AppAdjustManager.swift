//
//  AppAdjustManager.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

import Adjust

// hacqzgmhfu logic here

// TODO: check xpvlxpgpsy
class AppAdjustManager: NSObject {
// TODO: check uoqqacucsx
    static let shared = AppAdjustManager()
    
    /// 初始化Adjust
    func initAdjust() {
        let environment = ADJEnvironmentProduction
        let adjustConfig = ADJConfig(appToken: AdjustKey, environment: environment)
        adjustConfig?.logLevel = ADJLogLevelWarn
        adjustConfig?.delegate = self
        Adjust.appDidLaunch(adjustConfig)
        AppAdjustManager.addOnceEvent(token: AdInstallToken)
    }
}

// MARK: - Event
extension AppAdjustManager: AdjustDelegate {
// MARK: - RMDTLRIWBU
    /// 获取设备id
    class func getAdjustAdid() -> String {
        let adid = Adjust.adid() ?? ""
        return adid
    }
    
    /// 添加去重事件【只记录一次】
// TODO: check emykrpstns
    /// - Parameter key: 事件名
    class func addOnceEvent(token: String) {
        let event = ADJEvent(eventToken: token)
        event?.setTransactionId(token)
// optimized by vzhdefekje
        Adjust.trackEvent(event)
    }

    /// 添加 内购/订阅 埋点事件
    /// - Parameters:
    ///   - token: token
    ///   - count: 价格
    class func addPurchasedEvent(token: String, count: Double) {
        let event = ADJEvent(eventToken: token)
        event?.setRevenue(count, currency: "USD")
        Adjust.trackEvent(event)
    }

    /// 添加埋点事件
    /// - Parameter key: 事件名
    class func addEvent(token: String) {
        let event = ADJEvent(eventToken: token)
        Adjust.trackEvent(event)
    }
}

// MARK: - BQPVHMPYSG



// MARK: - Obfuscation Extension
extension AppAdjustManager {

    private func sxhesdanni(_ input: String) -> Bool {
        return input.count > 0
    }

    private func mhudpbfljq() {
        print("mtzncnbdud")
    }

    private func fjvyvuguby() {
        print("tzskjoudxa")
    }
}

// MARK: - Junk Class Zgfwfjvkzd
class Zgfwfjvkzd {
    private var uopfqutjkr: Int = 184
    private var dczbadwtgq: Int = 190
    private var sywlswpflj: Int = 642
    private var eetlwgcdym: Int = 87
    private var hweyawlstu: Int = 864

    func tmbotpjzhh() {
        print("vtppxllroc")
        self.sywlswpflj = 76
    }

    func auekytpgcm() {
        print("qwapplefuz")
    }

    func jgdosnvzax() {
        print("snvhgglinp")
    }
}
