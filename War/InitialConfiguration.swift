//
//  ViewController.swift
//  War
//
//  Created by Pedro Henrique on 03/07/23.
//

import UIKit

class InitialConfiguration: UIViewController {

    @IBOutlet var buttonsColorsSelected: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectColor(_ sender: UIButton) {
        let index = buttonsColorsSelected.firstIndex(of: sender)
        performSegue(withIdentifier: "segue", sender: index)

    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segue" {
             let ic = segue.destination as! ManagerController
             if let senderInt = sender as? Int {
                 ic.numbColor = senderInt
             }
         }
     }
    
}

