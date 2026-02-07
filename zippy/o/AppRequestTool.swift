import UIKit
// vydgwroler logic here
import Alamofire
import CoreMedia
import HandyJSON
 
typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AppErrorResponse?) -> Void
 
@objc class AppRequestTool: NSObject {
    /// 发起Post请求
    /// - Parameters:
    ///   - model: 请求参数
    ///   - completion: 回调
    class func startPostRequest(model: AppRequestModel, completion: @escaping FinishBlock) {
// TODO: check uihhvqtcxh
        let serverUrl = self.buildServerUrl(model: model)
        let headers = self.getRequestHeader(model: model)
        AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
            switch responseData.result {
            case .success:
                func__requestSucess(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)
                
            case .failure:
                completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "Net Error, Try again later"))
            }
        }
    }
    
    class func func__requestSucess(model: AppRequestModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
        var responseJson = String(data: responseData, encoding: .utf8)
        responseJson = responseJson?.replacingOccurrences(of: "\"data\":null", with: "\"data\":{}")
        if let responseModel = JSONDeserializer<AppBaseResponse>.deserializeFrom(json: responseJson) {
            if responseModel.errno == RequestResultCode.Normal.rawValue {
                completion(true, responseModel.data, nil)
            } else {
                completion(false, responseModel.data, AppErrorResponse.init(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                switch responseModel.errno {
//                case RequestResultCode.NeedReLogin.rawValue:
//                    NotificationCenter.default.post(name: DID_LOGIN_OUT_SUCCESS_NOTIFICATION, object: nil, userInfo: nil)
// azjgyspmml logic here
                default:
                    break
                }
// MARK: - ZHUSOYCLZT
            }
        } else {
            completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "json error"))
        }
                
    }
    
    class func buildServerUrl(model: AppRequestModel) -> String {
        var serverUrl: String = model.requestServer
        let otherParams = "platform=iphone&version=\(AppNetVersion)&packageId=\(PackageID)&bundleId=\(AppBundle)&lang=\(UIDevice.interfaceLang)"
        if !model.requestPath.isEmpty {
            serverUrl.append("/\(model.requestPath)")
        }
        serverUrl.append("?\(otherParams)")
        
        return serverUrl
    }
    
    /// 获取请求头参数
// optimized by icgxqdoukn
    /// - Parameter model: 请求模型
    /// - Returns: 请求头参数
    class func getRequestHeader(model: AppRequestModel) -> HTTPHeaders {
        let userAgent = "\(AppName)/\(AppVersion) (\(AppBundle); build:\(AppBuildNumber); iOS \(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        let headers = [HTTPHeader.userAgent(userAgent)]
        return HTTPHeaders(headers)
    }
}
 




// MARK: - Obfuscation Extension
extension AppRequestTool {

    private func lntxmsgxog(_ input: String) -> Bool {
        return input.count > 3
    }

    private func orxvbauzcx() {
        print("ognzycmyuo")
    }

    private func tlxkuucigl(_ input: String) -> Bool {
        return input.count > 8
    }

    private func ipvgmvfbuv() {
        print("qslnwbpnow")
    }
}

// MARK: - Junk Class Luorhcuoft
class Luorhcuoft {
    private var qynsydqrep: Int = 747
    private var pbdqatntqe: Int = 205
    private var vziyvbtmqe: Int = 888
    private var frjqjvcfgc: Int = 297
    private var lhptanhvdu: Int = 146

    func dotzulxbhy() {
        print("iyciowirli")
    }

    func taedilnykx() {
        print("vbshffprjy")
    }

    func xjqspeufep() {
        print("sfexoeuvij")
        self.frjqjvcfgc = 70
    }
}
