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
    var numberTerritories: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPlayer(number: numbColor ?? 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        exibirPopUp()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Converte Int em String
    func convertIntToString(number: Int) -> String {
        if number.isMultiple(of: 2) {
            return String(number)
        } else {
            let resultArredondadoParaBaixo = Int(floor(Double(number)))
            return String(resultArredondadoParaBaixo)
        }
    }
    
    //Converte String em Int
    func convertStringToInt(text: String) -> Int {
        let convert = Int(text)
        return convert ?? 0
    }
    
    @IBAction func updateArmiesAvailable(_ sender: Any) {
        if let numberTerritoriesConquered = textFieldAmountTerritoriesConquered.text, let numbTerritories = numberTerritories {
            numberTerritories = numbTerritories + (Int(numberTerritoriesConquered) ?? 0)
            textFieldAmountTerritoriesConquered.text = ""
            checkSwitchOn()
            updateViewInformation()
            
        }
        
    }
    
    //Método que cria e exibe um Alert assim que a tela de informações aparece.
    func exibirPopUp() {
        let alertController = UIAlertController(title: "Digite o número de territórios iniciais", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Ex:15"
            textField.keyboardType = .numberPad
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: textField)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first, let texto = textField.text {
                let valor = Int(texto) ?? 0
                self.numberTerritories = valor
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
    
    func checkSwitchOn() {
        guard let armys = numberTerritories else { return }
        var totalTerritories = armys
        
        for switchControl in switchConqueredContinents {
            if switchControl.isOn {
                switch switchControl {
                case switchConqueredContinents[0]:
                    totalTerritories += 7
                case switchConqueredContinents[1]:
                    totalTerritories += 7
                case switchConqueredContinents[2]:
                    totalTerritories += 3
                case switchConqueredContinents[3]:
                    totalTerritories += 4
                case switchConqueredContinents[4]:
                    totalTerritories += 3
                default:
                    totalTerritories += 10
                }
            }
        }
        
        numberTerritories = totalTerritories
    }
    
    //Atualiza as informações das Labels
    func updateViewInformation() {
        DispatchQueue.main.async {
            self.labelTotalTerritoriesConquered.text = self.convertIntToString(number: self.numberTerritories ?? 0)
            self.labelArmyAvailable.text = self.convertIntToString(number: (self.numberTerritories ?? 0)/2)
        }
    }
    
    //Método que verifica qual cor o jogador escolheu.
    func colorPlayer(number: Int) {
        switch number {
            case 0:
                if let imagem = UIImage(named: "bola-branca") {
                    imageViewColorPlayer.image = imagem
                }
            case 1:
                if let imagem = UIImage(named: "bola-preta") {
                    imageViewColorPlayer.image = imagem
                }
            case 2:
                if let imagem = UIImage(named: "bola-verde") {
                    imageViewColorPlayer.image = imagem
                }
            case 3:
                if let imagem = UIImage(named: "bola-vermelha") {
                    imageViewColorPlayer.image = imagem
                }
            case 4:
                if let imagem = UIImage(named: "bola-azul") {
                    imageViewColorPlayer.image = imagem
                }
            default:
                if let imagem = UIImage(named: "bola-amarela") {
                    imageViewColorPlayer.image = imagem
                }
        }
    }
}
