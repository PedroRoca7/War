//
//  ViewModel.swift
//  War
//
//  Created by Pedro Henrique on 10/07/23.
//

import Foundation
import UIKit

class ViewModel {
    
    private enum colorArmyPlayer: String {
        case white = "bola-branca"
        case black = "bola-preta"
        case green = "bola-verde"
        case red = "bola-vermelha"
        case blue = "bola-azul"
        case yellow = "bola-amarela"
    }
    
    private var numberTerritories: Int
    
    init(numberTerritories: Int) {
        self.numberTerritories = numberTerritories
    }
    
    var getNumberTerritories: Int {
        return numberTerritories
    }
    
    public func setNumberTerritories(value: Int) {
        numberTerritories += value
    }
    
    //Método que verifica qual cor o jogador escolheu.
    public func colorPlayer(number: Int) -> String {
        switch number {
        case 0:
            return colorArmyPlayer.white.rawValue
        case 1:
            return colorArmyPlayer.black.rawValue
        case 2:
            return colorArmyPlayer.green.rawValue
        case 3:
            return colorArmyPlayer.red.rawValue
        case 4:
            return colorArmyPlayer.blue.rawValue
        default:
            return colorArmyPlayer.yellow.rawValue
        }
    }
    
    //Arredonda o valor para baixo
    public func roundDown(number: Int) -> Int {
        if number.isMultiple(of: 2) {
            return number
        } else {
            let resultArredondadoParaBaixo = Int(floor(Double(number)))
            return resultArredondadoParaBaixo
        }
    }
    
    public func checkSwitchOn(switchConqueredContinents: [UISwitch]) {
        var totalTerritories = numberTerritories
            
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
}
