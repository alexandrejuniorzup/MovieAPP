//
//  ExtensionViewController.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit
import Reachability

extension UIViewController {
 
    func alertNoConnection(){
        let alert = UIAlertController(title: "Sem conexão com internet", message: "Tente novamente mais tarde", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func genericAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func verifyConnection() -> Bool {
        let reachability = Reachability()!
        if reachability.connection == .none {
            return false
        }
        return true
    }
    
    func setBackGround() {
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}


