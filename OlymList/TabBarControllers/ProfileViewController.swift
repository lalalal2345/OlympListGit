import UIKit
import PhoneNumberKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var PhoneKitTF: PhoneNumberTextField!
    @IBOutlet weak var passTFOutlet: UITextField!
    @IBOutlet weak var logoutButtonOutlet: UIButton!
    @IBOutlet weak var blurViewOutletl: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        
        passTFOutlet.enablePasswordToggle()
        
        PhoneKitTF.delegate = self
        passTFOutlet.delegate = self
        
        PhoneKitTF.defaultRegion = "GB"
        PhoneKitTF.withFlag = true
        PhoneKitTF.withPrefix = true
        PhoneKitTF.withPrefixPrefill = true
        PhoneKitTF.withExamplePlaceholder = true
        PhoneKitTF.withDefaultPickerUI = true
        //PhoneKitTF.setLeftView(PhoneKitTF.leftView!, padding: 20)
        
        if UserDefaults.standard.bool(forKey: Constants.loginStatus) == false {
            blurViewOutletl.isHidden = true
            logoutButtonOutlet.isHidden = true
        } else {
            blurViewOutletl.isHidden = false
            logoutButtonOutlet.isHidden = false
        }
        
    }
    
    @objc func addTapped() {
        print("tapped")
    }
    
    @IBAction func goButtonAction(_ sender: UIButton) {
        print(PhoneKitTF.text ?? "")
        print(passTFOutlet.text ?? "")
        
        var clearPhone = PhoneKitTF.text ?? ""
        clearPhone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var newClearedPhone = clearPhone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        newClearedPhone = "+\(newClearedPhone)"
        
        
        if newClearedPhone == "+375336169390" && passTFOutlet.text == "adminpass" {
            passTFOutlet.text = ""
            let alert = UIAlertController(title: "Hello", message: "You are logged in ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let historyVC = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                    let helpVC = storyBoard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
            
            tabBarController?.viewControllers?.insert(historyVC, at: 1)
            tabBarController?.viewControllers?.insert(helpVC, at: 3)
            
            blurViewOutletl.isHidden = false
            logoutButtonOutlet.isHidden = false
            
            UserDefaults.standard.setValue(true, forKey: Constants.loginStatus)
        }
    }
        
    func configureButton() {
        buttonOutlet.setTitle("Enter", for: .normal)
        buttonOutlet.layer.cornerRadius = 5
        buttonOutlet.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)!
        buttonOutlet.backgroundColor = UIColor.orange
        let scanHighlightedColor = UIColor.systemOrange
        buttonOutlet.setBackgroundColor(scanHighlightedColor, forState: .highlighted)
        
        logoutButtonOutlet.setTitle("Log out", for: .normal)
        logoutButtonOutlet.layer.cornerRadius = 5
        logoutButtonOutlet.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)!
        logoutButtonOutlet.backgroundColor = UIColor.orange
        let scanHighlightedColor2 = UIColor.systemOrange
        logoutButtonOutlet.setBackgroundColor(scanHighlightedColor2, forState: .highlighted)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurViewOutletl.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurViewOutletl.insertSubview(blurEffectView, at: 0)
    }
    
    @IBAction func noAccTapGesture(_ sender: UITapGestureRecognizer) {
        print("no acc")
        
        let alert = UIAlertController(title: "Registration is not available", message: "To get access to your personal account, contact the club administrator", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == PhoneKitTF || textField == passTFOutlet {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.orange.cgColor
            textField.layer.cornerRadius = 5
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == PhoneKitTF || textField == passTFOutlet {
            textField.layer.borderWidth = 0.25
            textField.layer.borderColor = UIColor.darkGray.cgColor
            textField.layer.cornerRadius = 5
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        print("logout")
        tabBarController?.viewControllers?.remove(at: 1)
        tabBarController?.viewControllers?.remove(at: 2)
        
        blurViewOutletl.isHidden = true
        logoutButtonOutlet.isHidden = true
        
        UserDefaults.standard.setValue(false, forKey: Constants.loginStatus)
    }
}
