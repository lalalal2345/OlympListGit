//
//  HelpViewController.swift
//  OlymList
//
//  Created by Герман Юрченко on 4.09.24.
//

import UIKit

class HelpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var cityChosed = ""
    var timeChosed = ""
    var dataChosed = ""
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    @IBOutlet weak var bokkingButtonOutletl: UIButton!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var cityPickerOutlet: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        self.cityPickerOutlet.delegate = self
        self.cityPickerOutlet.dataSource = self

        pickerData = ["Moskow", "Astrakhan", "Voronezh", "Kazan", "Rostov-on-Don", "Smolensk", "Astrakhan", "Voronezh", "Sochi", "Perm", "Moskow", "Samara", "Penza"]
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityChosed = pickerData[row]
            // This method is triggered whenever the user makes a change to the picker selection.
            // The parameter named row and component represents what was selected.
        }
    
    func configureButton() {
        bokkingButtonOutletl.setTitle("Book this time", for: .normal)
        bokkingButtonOutletl.layer.cornerRadius = 5
        bokkingButtonOutletl.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)!
        bokkingButtonOutletl.backgroundColor = UIColor.orange
        let scanHighlightedColor = UIColor.systemOrange
        bokkingButtonOutletl.setBackgroundColor(scanHighlightedColor, forState: .highlighted)
    }

    @IBAction func datePickeAction(_ sender: UIDatePicker) {
        dataChosed = dateFormatter.string(from: datePickerOutlet.date)
        timeChosed = timeFormatter.string(from: datePickerOutlet.date)
    }
    
    @IBAction func bookingButtonAction(_ sender: UIButton) {
        if timeChosed != "" && dataChosed != "" && cityChosed != "" {
            let alert = UIAlertController(title: "Cyber club succesfully booked", message: "\(cityChosed), \(dataChosed), \(timeChosed)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Please check all fields", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        print(timeChosed)
        print(dataChosed)
        print(cityChosed)
        
    }
}
