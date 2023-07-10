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
    
    var viewModel: ViewModel?
    var numbColor: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        exibirPopUp()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func updateArmiesAvailable(_ sender: Any) {
        if let numberTerritoriesConquered = textFieldAmountTerritoriesConquered.text {
            viewModel?.setNumberTerritories(value: Int(numberTerritoriesConquered) ?? 0)
            textFieldAmountTerritoriesConquered.text = ""
            viewModel?.checkSwitchOn(switchConqueredContinents: switchConqueredContinents)
            updateViewInformation()
            
        }
    }
    
    private func setImageColorPlayer() {
        guard let colorPlayer = viewModel?.colorPlayer(number: numbColor ?? 0) else { return }
        imageViewColorPlayer.image = UIImage(named: colorPlayer)
    }
    
    //Método que cria e exibe um Alert assim que a tela de informações aparece.
    private func exibirPopUp() {
        let alertController = UIAlertController(title: "Digite o número de territórios iniciais", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Ex:15"
            textField.keyboardType = .numberPad
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: textField)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first, let texto = textField.text {
                let valor = Int(texto) ?? 0
                self.viewModel = ViewModel(numberTerritories: valor)
                self.setImageColorPlayer()
                self.updateViewInformation()
            }
        }
        okAction.isEnabled = false
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Método que verifica se o textField do Alert está vazio e se é maior que zero
    @objc func handleTextFieldTextDidChangeNotification(_ notification: Notification) {
        if let alertController = presentedViewController as? UIAlertController,
           let textField = alertController.textFields?.first,
           let okAction = alertController.actions.first {
            if let texto = textField.text, let valor = Int(texto) {
                okAction.isEnabled = valor > 0
            } else {
                okAction.isEnabled = false
            }
        }
    }
    
    //Atualiza as informações das Labels
    private func updateViewInformation() {
        guard let numberTerritories = self.viewModel?.getNumberTerritories else { return }
        self.labelTotalTerritoriesConquered.text = String(numberTerritories)
        let armyAvailable = self.viewModel?.roundDown(number: numberTerritories/2)
        self.labelArmyAvailable.text = String(armyAvailable ?? 0)
    }
    
    
}
