//
//  ManagerController.swift
//  War
//
//  Created by Pedro Henrique on 03/07/23.
//

import UIKit

class InfoArmyViewController: UIViewController {
    
    @IBOutlet weak var imageViewColorPlayer: UIImageView!
    @IBOutlet weak var labelTotalTerritoriesConquered: UILabel!
    @IBOutlet weak var textFieldAmountTerritoriesConquered: UITextField!
    @IBOutlet weak var labelArmyAvailable: UILabel!
    @IBOutlet var switchConqueredContinents: [UISwitch]!
    
    var viewModel: ViewModel = ViewModel()
    var numbColor: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AlertManager.showAlert(in: self) { [weak self] valor in
            self?.viewModel.setNumberTerritories(value: valor)
            self?.setImageColorPlayer()
            self?.updateViewInformation()
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func updateArmiesAvailable(_ sender: Any) {
        if let numberTerritoriesConquered = textFieldAmountTerritoriesConquered.text {
            viewModel.setNumberTerritories(value: Int(numberTerritoriesConquered) ?? 0)
            textFieldAmountTerritoriesConquered.text = ""
            viewModel.checkSwitchOn(switchConqueredContinents: switchConqueredContinents)
            updateViewInformation()
            
        }
    }
    
    private func setImageColorPlayer() {
        let colorPlayer = viewModel.colorPlayer(number: numbColor)
        imageViewColorPlayer.image = UIImage(named: colorPlayer)
    }
    //Atualiza as informações das Labels
    private func updateViewInformation() {
        let numberTerritories = self.viewModel.getNumberTerritories
        self.labelTotalTerritoriesConquered.text = String(numberTerritories)
        let armyAvailable = self.viewModel.roundDown(number: numberTerritories/2)
        self.labelArmyAvailable.text = String(armyAvailable)
    }
    
    
}
