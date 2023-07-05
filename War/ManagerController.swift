//
//  ManagerController.swift
//  War
//
//  Created by Pedro Henrique on 03/07/23.
//

import UIKit

class ManagerController: UIViewController {
    
    @IBOutlet weak var imageViewColorPlayer: UIImageView!
    @IBOutlet weak var labelTotalTerritoriesConquered: UILabel!
    @IBOutlet weak var textFieldAmountTerritoriesConquered: UITextField!
    @IBOutlet weak var labelArmyAvailable: UILabel!
    @IBOutlet var switchConqueredContinents: [UISwitch]!
    
    var numbColor: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let numberColor = numbColor {
            labelTotalTerritoriesConquered.text = convertIntToString(number: numberColor)
        }
    }
    
    func convertIntToString(number: Int) -> String {
        let convert = String(number)
        return convert
    }
    
    func convertStringToInt(text: String) -> Int {
        let convert = Int(text)
        return convert ?? 0
    }
    
    @IBAction func updateArmiesAvailable(_ sender: Any) {
    }
    
    
}
