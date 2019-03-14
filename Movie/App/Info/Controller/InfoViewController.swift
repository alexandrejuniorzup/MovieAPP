//
//  InfoViewController.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import UIKit
import JGProgressHUD

class InfoViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var lbRated: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    var model: InfoViewModel!
    
    static func instantiate(viewModel: InfoViewModel) -> InfoViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        viewController.model = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        let hud = JGProgressHUD(style: .dark)
        hud.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view, animated: false)
        setBackGround()
        model.getMovieID() { () in
            self.posterImage.sd_setImage(with: URL(string: self.model.service.getImageUrl(url: self.model.poster()))!, completed: nil)
            self.lbYear.text = "Ano: " + self.model.year()
            self.lbGenre.text = self.model.genre()
            self.lbRuntime.text = self.model.runTime() + " min"
            self.lbRated.text = "Avaliação: " + self.model.rated()
            self.lbOverview.text = "Plot: " + self.model.plot()
            self.navigationItem.title = self.model.title()
            if self.model.fromDatabase{
                self.btnSave.isHidden = true
                self.btnRemove.isHidden = false
            }
            hud.dismiss()
        }
    }
    
    @IBAction func saveMovie(_ sender: Any) {
        if self.model.save(){
            btnSave.isHidden = true
            btnRemove.isHidden = false
        } else {
            genericAlert(title: "Filme já está salvo nos favoritos", message: "")        }
    }
    
    
    @IBAction func deleteMove(_ sender: Any) {
        model.remove()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension InfoViewController: InfoViewModelDelegate {
    
    func presentErrorConnection() {
        alertNoConnection()
    }
    
    
}
