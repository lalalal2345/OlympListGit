import UIKit
import WebKit

class QRViewController: UIViewController {
    
    @IBOutlet weak var scanButtonOutlet: UIButton!
    @IBOutlet weak var writeManButtonOutlet: UIButton!
    
    let freok = ""
    
    var browsObject: WKWebView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @IBAction func scanButton(_ sender: UIButton) {
        print("scan")
        let cameraVc = UIImagePickerController()
        cameraVc.sourceType = UIImagePickerController.SourceType.camera
        self.present(cameraVc, animated: true, completion: nil)
    }
    
    @IBAction func wrireManuallyButton(_ sender: UIButton) {
        print("manual")
        
        weak var textField : UITextField?

           let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
               print("Cancel Pressed", textField?.text ?? "n/a")
           }
        
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                print("Ok Pressed", textField?.text ?? "n/a")
            }
          
            let handler : (UITextField) -> Void = { textField = $0 }
        
           self.showAlertWithTextField(title: "Enter the code", message: nil, actions: [cancelAction, okAction], style: .alert, handler: handler, completion: nil)
    }
    
    func configureButton() {
        scanButtonOutlet.setTitle("Scan QR-code", for: .normal)
        scanButtonOutlet.layer.cornerRadius = 16
        scanButtonOutlet.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)!
        scanButtonOutlet.backgroundColor = UIColor.orange
        let scanHighlightedColor = UIColor.systemOrange
        scanButtonOutlet.setBackgroundColor(scanHighlightedColor, forState: .highlighted)
        
        
        writeManButtonOutlet.setTitle("Set code manually", for: .normal)
        writeManButtonOutlet.titleLabel?.text = "Set code manually"
        writeManButtonOutlet.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)!
        writeManButtonOutlet.setTitleColor(.orange, for: .normal)
        writeManButtonOutlet.layer.borderWidth = 2
        writeManButtonOutlet.layer.cornerRadius = 16
        writeManButtonOutlet.layer.borderColor = UIColor.orange.cgColor
        let writeHighlightedColor = #colorLiteral(red: 0.08196888093, green: 0.1449400968, blue: 0.3074831495, alpha: 1)
        writeManButtonOutlet.setBackgroundColor(writeHighlightedColor, forState: .highlighted)
    }
}
