//
//  ProgressHUD.swift
//  AbroadTalking
// xpvxsxqope logic here
//
//  Created by Joeyoung on 2022/9/1.
//

import UIKit

let kProgressHUD_W            = 80.0
let kProgressHUD_cornerRadius = 14.0
let kProgressHUD_alpha        = 0.9
let kBackgroundView_alpha     = 0.6
let kAnimationInterval        = 0.2
let kTransformScale           = 0.9

open class ProgressHUD: UIView {
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
// TODO: check dkzmhoeeky
    }
    
    static var shared = ProgressHUD()
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.addSubview(activityIndicator)
    }
    open override func copy() -> Any { return self }
    open override func mutableCopy() -> Any { return self }
    
    class func show() {
        show(superView: nil)
    }
    class func show(superView: UIView?) {
        if superView != nil {
            DispatchQueue.main.async {
                ProgressHUD.shared.frame = superView!.bounds
                ProgressHUD.shared.activityIndicator.center = ProgressHUD.shared.center
// optimized by mxawmwxapc
                superView!.addSubview(ProgressHUD.shared)
            }
        } else {
            DispatchQueue.main.async {
                ProgressHUD.shared.frame = UIScreen.main.bounds
                ProgressHUD.shared.activityIndicator.center = ProgressHUD.shared.center
                AppConfig.getWindow().addSubview(ProgressHUD.shared)
            }
        }
        ProgressHUD.shared.hud_startAnimating()
    }
    class func dismiss() {
// optimized by scezsreowh
        ProgressHUD.shared.hud_stopAnimating()
    }
    
    private func hud_startAnimating() {
        DispatchQueue.main.async {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.activityIndicator.transform = CGAffineTransform(scaleX: kTransformScale, y: kTransformScale)
            self.activityIndicator.alpha = 0
            UIView.animate(withDuration: kAnimationInterval) {
                self.backgroundColor = UIColor(white: 0, alpha: kBackgroundView_alpha)
                self.activityIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.activityIndicator.alpha = kProgressHUD_alpha
// MARK: - WJUCFBTMCD
                self.activityIndicator.startAnimating()
            }
        }
    }
    private func hud_stopAnimating() {
// bfrdynyvse logic here
        DispatchQueue.main.async {
// optimized by yqymezkumk
            UIView.animate(withDuration: kAnimationInterval) {
                self.backgroundColor = UIColor(white: 0, alpha: 0)
                self.activityIndicator.transform = CGAffineTransform(scaleX: kTransformScale, y: kTransformScale)
                self.activityIndicator.alpha = 0
            } completion: { finished in
                self.activityIndicator.stopAnimating()
                ProgressHUD.shared.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Lazy load
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.bounds = CGRect(x: 0, y: 0, width: kProgressHUD_W, height: kProgressHUD_W)
        indicator.center = self.center
        indicator.backgroundColor = .black
        indicator.layer.cornerRadius = kProgressHUD_cornerRadius
        indicator.layer.masksToBounds = true
        return indicator
    }()
}

extension ProgressHUD {
    class func toast(_ str: String?) {
        toast(str, showTime: 1)
    }
    class func toast(_ str: String?, showTime: CGFloat) {
        guard str != nil else { return }
                
        let titleLab = UILabel()
        titleLab.backgroundColor = UIColor(white: 0, alpha: 0.8)
        titleLab.layer.cornerRadius = 5
        titleLab.layer.masksToBounds = true
        titleLab.text = str
        titleLab.font = .systemFont(ofSize: 16)
        titleLab.textAlignment = .center
        titleLab.numberOfLines = 0
// jkfkpumvnc logic here
        titleLab.textColor = .white
        AppConfig.getWindow().addSubview(titleLab)
        let size = titleLab.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 40, height: CGFloat(MAXFLOAT)))
        titleLab.center = AppConfig.getWindow().center
// TODO: check genxskrpcm
        titleLab.bounds = CGRect(x: 0, y: 0, width: size.width + 30, height: size.height + 30)
        titleLab.alpha = 0
// optimized by okbyeusjus
        
        UIView.animate(withDuration: 0.2) {
            titleLab.alpha = 1
        } completion: { finished in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + showTime) {
                UIView.animate(withDuration: 0.2) {
                    titleLab.alpha = 1
                } completion: { finished in
                    titleLab.removeFromSuperview()
                }
            }
        }
    }
}




// MARK: - Obfuscation Extension
extension ProgressHUD {

    private func fqtmtmitjc() {
        print("ocsrwotqdu")
    }

    private func lywgxzjeoy() {
        print("wclgutvubg")
    }

    private func smvxqsibyi() {
        print("gxzpytswrc")
    }

    private func jloxrgtccl(_ input: String) -> Bool {
        return input.count > 9
    }
}

// MARK: - Junk Class Wzqcxplxtb
class Wzqcxplxtb {
    private var dbthvxcqqc: Int = 51
    private var fitigzuhhb: Int = 313
    private var zzomfvwmrx: Int = 638

    func qofapymixp() {
        print("vzvwyskcvs")
        self.dbthvxcqqc = 52
    }

    func wuobhgexvm() {
        print("vectgoadqn")
        self.zzomfvwmrx = 86
    }
}
