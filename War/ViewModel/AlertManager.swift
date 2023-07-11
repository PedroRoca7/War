//
//  AlertManager.swift
//  War
//
//  Created by Pedro Henrique on 11/07/23.
//

import UIKit

class AlertManager {
    
    static func showAlert(in viewController: UIViewController, completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: "Digite o número de territórios iniciais", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Ex:15"
            textField.keyboardType = .numberPad
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
                let textFieldValue = textField.text ?? ""
                let value = Int(textFieldValue) ?? 0
                alertController.actions.first?.isEnabled = value > 0
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first, let texto = textField.text {
                let valor = Int(texto) ?? 0
                completion(valor)
            }
        }
        okAction.isEnabled = false
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
