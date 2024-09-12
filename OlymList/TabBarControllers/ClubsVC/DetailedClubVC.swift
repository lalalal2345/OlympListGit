//
//  DetailedClubVC.swift
//  OlymList
//
//  Created by Герман Юрченко on 4.09.24.
//

import UIKit

class DetailedClubVC: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var timeLabelOutlet: UILabel!
    
    @IBOutlet weak var locationLabelOutlet: UILabel!
    
    var clubNumber: Int = 0
    
    let clubsInfoArray: [ClubsModel] = [
    ClubsModel(photoName: "1", city: "Moskow", adress: "Gagarina 3/a", workingTime: "Mon-Fri 8:00-00:00"),
    ClubsModel(photoName: "2", city: "Astrakhan", adress: "Alibegova 124", workingTime: "Mon-Sun 8:00-00:00"),
    ClubsModel(photoName: "3", city: "Voronezh", adress: "Frunzi 43", workingTime: "Mon-Sat 8:00-01:00"),
    ClubsModel(photoName: "4", city: "Kazan", adress: "Mochenikov 75", workingTime: "Mon-Sun 8:00-00:00"),
    ClubsModel(photoName: "5", city: "Rostov-on-Don", adress: "Ignata Bory 5b", workingTime: "Mon-Sun 02:00-00:00"),
    ClubsModel(photoName: "6", city: "Smolensk", adress: "Bibriosha 12/2", workingTime: "Mon-Fri 8:00-00:00"),
    ClubsModel(photoName: "7", city: "Astrakhan", adress: "Esenina 11a", workingTime: "Mon-Sun 8:00-00:00"),
    ClubsModel(photoName: "8", city: "Voronezh", adress: "Ygo-zapad 3", workingTime: "Mon-Sat 8:00-11:00"),
    ClubsModel(photoName: "9", city: "Sochi", adress: "Pushkina 2", workingTime: "Mon-Sun 8:00-12:00"),
    ClubsModel(photoName: "10", city: "Perm", adress: "Kiluna 87", workingTime: "Mon-Fri 8:00-10:00"),
    ClubsModel(photoName: "11", city: "Samara", adress: "Gogolya 22", workingTime: "Mon-Sun 8:00-00:00"),
    ClubsModel(photoName: "12", city: "Penza", adress: "Foera 3", workingTime: "Mon-Sun 8:00-00:00")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clubsInfoArray[clubNumber].city
        mainImageView.image = UIImage(named: "\(clubsInfoArray[clubNumber].photoName)")
        locationLabelOutlet.text = clubsInfoArray[clubNumber].adress
        timeLabelOutlet.text = clubsInfoArray[clubNumber].workingTime
    }
    
}
