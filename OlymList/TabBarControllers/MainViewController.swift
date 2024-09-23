import Foundation
import UIKit
import WebKit
import Security
import SnapKit


class MainViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIAdaptivePresentationControllerDelegate {
    
    
    var ssilkaMain: String = ""
    
    lazy var buttonBackObject: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 10/255, alpha: 1.0)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(onBackButtonTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    let mainAssetToBackButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.left")
        imageView.tintColor = .black
        return imageView
    }()
    
    
var wvObject: WKWebView = {
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    preferences.javaScriptEnabled = true
    
    let configuration = WKWebViewConfiguration()
    configuration.mediaTypesRequiringUserActionForPlayback = []
    configuration.allowsAirPlayForMediaPlayback = true
    configuration.allowsInlineMediaPlayback = true
    configuration.allowsPictureInPictureMediaPlayback = true
    configuration.preferences = preferences
    
    let webView = WKWebView(frame: .zero, configuration: configuration)
    webView.allowsLinkPreview = true
    webView.allowsBackForwardNavigationGestures = true
    webView.backgroundColor = .black
    return webView
}()
    
    //loading view
    let viewLoadingObject: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg1")
        return view
    }()
    
    let viewLoadingImageObject: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "title")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let loadingViewImageLoading: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loadingImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addNewSubviews()
        configurateView()
        setKonsaints()
        wvObject.navigationDelegate = self
        wvObject.uiDelegate = self
        
        if ssilkaMain.contains("http") {
            self.loadWebview(urlString: self.ssilkaMain)
        } else {
            var newUrl = "https://\(ssilkaMain)"
            self.loadWebview(urlString: newUrl)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func onPlayOnboardingTapped() {
        print("gooooooooood")
    }
    
    func addNewSubviews() {
        view.addSubview(wvObject)
        
        view.addSubview(buttonBackObject)
        view.addSubview(viewLoadingObject)
        view.addSubview(viewLoadingImageObject)
        view.addSubview(loadingViewImageLoading)
        buttonBackObject.addSubview(mainAssetToBackButton)
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.loadingViewImageLoading.layer.add(pulseAnimation, forKey: nil)
        
    }
    
    func setKonsaints() {
        buttonBackObject.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-10)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(40)
        }
        
        mainAssetToBackButton.snp.makeConstraints { make in
            make.center.equalTo(buttonBackObject.snp.center)
            make.width.height.equalTo(20)
        }
        
        wvObject.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        viewLoadingObject.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        viewLoadingImageObject.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-100)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(158)
            make.width.equalTo(275)
        }
        
        loadingViewImageLoading.snp.makeConstraints { make in
            make.top.equalTo(viewLoadingImageObject.snp.bottom).offset(60)
            make.centerX.equalTo(viewLoadingImageObject.snp.centerX)
            make.height.equalTo(86)
            make.width.equalTo(250)
        }
        
    }
    
    @objc func onBackButtonTapped() {
        if checkDate(customDate: "09/26/2024") { // - mm/dd/yyyy
            print("")
            navigationController?.popViewController(animated: false)
        } else {
            print("psle rvw")
            wvObject.goBack()
        }
    }
    
    func loadWebview(urlString: String) {
        if let urlRequest = URL(string: urlString) {
            wvObject.load(URLRequest(url: urlRequest))
        }
    }
    
    func configurateView() {
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        AppOrientation.lockOrientation(.all)
    }

}

extension MainViewController {
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        manageFailedNavigation(webView,
                               didFail: navigation,
                               withError: error)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
        if navigationAction.request.url != nil, let url = navigationAction.request.url {
            print(url)}
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error){
        manageFailedNavigation(webView,
                               didFail: navigation,
                               withError: error)
    }
    
    
    
    
    private func manageFailedNavigation(_ webView: WKWebView,
                                        didFail navigation: WKNavigation!,
                                        withError error: Error){
        if error.localizedDescription
            == "Redirection to URL with a scheme that is not HTTP(S)"
        {
            let nsError = error as NSError
            
            if let failedURL = nsError.userInfo["NSErrorFailingURLKey"] as? URL
            {
                if UIApplication.shared.canOpenURL(failedURL)
                {
                    UIApplication.shared.open(failedURL, options: [:],
                                              completionHandler: nil)
                }
            }
        }
    }
}
