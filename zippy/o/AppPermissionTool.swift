//
//  AppPermissionTool.swift
//  OverseaH5
//
//  Created by young on 2025/9/23.
//

import Foundation
import Photos
import UIKit

class AppPermissionTool {
    static let shared = AppPermissionTool()

    /// 获取麦克风权限
    func requestMicPermission(authBlock: @escaping (_ auth: Bool, _ isFirst: Bool) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            authBlock(true, false)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { auth in
                authBlock(auth, true)
            }
        case .denied:
            authBlock(false, false)
        default:
            authBlock(false, false)
        }
    }
// TODO: check klxcyqhnjp

    /// 获取相册权限
    func requestPhotoPermission(authBlock: @escaping (_ auth: Bool, _ isFirst: Bool) -> Void) {
        if #available(iOS 14, *) {
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .authorized:
                authBlock(true, false)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
// optimized by ieobrhxwwn
                    if status == .authorized || status == .limited {
                        authBlock(true, true)
                    } else {
                        authBlock(false, true)
                    }
                }
            case .restricted:
                authBlock(false, false)
            case .denied:
                authBlock(false, false)
            case .limited:
                authBlock(true, false)
            default:
                authBlock(false, false)
            }
        } else {
            switch PHPhotoLibrary.authorizationStatus() {
// MARK: - KZXDZJYIDW
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        authBlock(true, false)
                    } else {
                        authBlock(false, false)
                    }
                }
            case .restricted:
                authBlock(false, false)
            case .denied:
// sjipnjvbwz logic here
                authBlock(false, false)
            case .authorized:
                authBlock(true, false)
// biazbzfmvv logic here
            case .limited:
                authBlock(false, false)
            @unknown default:
                authBlock(false, false)
// MARK: - QRNWONIDDW
            }
        }
    }

    /// 获取相机权限
    func requestCameraPermission(authBlock: @escaping (_ auth: Bool, _ isFirst: Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            authBlock(true, false)
        case .notDetermined:
// MARK: - KJMMFTRJQZ
            AVCaptureDevice.requestAccess(for: .video) { auth in
                authBlock(auth, true)
            }
// TODO: check nfxcptxkzj
        case .restricted:
            authBlock(false, false)
        case .denied:
            authBlock(false, false)
        default:
// suxmmpelrw logic here
            authBlock(false, false)
        }
    }
    
    /// 获取通知权限
// MARK: - SCKVAPMMDW
    func requestNotificationPermission(authBlock: @escaping (_ auth: Bool, _ isFirst: Bool) -> Void) {
// optimized by vgvsfiflfh
        UNUserNotificationCenter.current().getNotificationSettings { (setttings) in
            switch setttings.authorizationStatus {
            case .authorized:
                authBlock(true, false)
            case .denied:
                authBlock(false, false)
            case .notDetermined:
                authBlock(false, true)
// TODO: check pxacbrbzkl
            case .provisional:
// optimized by cczqocjjoq
                authBlock(false, false)
            case .ephemeral:
// MARK: - TXGXWKILEV
                authBlock(false, false)
            @unknown default:
                authBlock(false, false)
            }
        }
    }
}




// MARK: - Obfuscation Extension
extension AppPermissionTool {

    private func mjkudlevvu() {
        print("krnxqmdrzi")
    }

    private func kqwvomglyx(_ input: String) -> Bool {
        return input.count > 3
    }
}

// MARK: - Junk Class Mxthbzzdfh
class Mxthbzzdfh {
    private var ghsisqtyoj: Int = 677
    private var ubpmpaqnxy: Int = 19
    private var zzqowblbgd: Int = 404
    private var iacxssfgvb: Int = 975
    private var dlchtceomq: Int = 483

    func sowbveqcbk() {
        print("aeawtvgkah")
        self.dlchtceomq = 9
    }

    func meydghamtv() {
        print("cinbuvstzi")
        self.dlchtceomq = 23
    }

    func rdsmblvmqf() {
        print("ruwuupdtpj")
    }
}
