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
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var lbRated: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    var model: InfoViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = JGProgressHUD(style: .dark)
        hud.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view, animated: false)
        model.getMovieID() { () in
            self.ivPoster.sd_setImage(with: URL(string: self.model.service.getImageUrl(url: self.model.poster()))!, completed: nil)
            self.lbYear.text = "Ano: " + self.model.year()
            self.lbGenre.text = self.model.genre()
            self.lbRuntime.text = self.model.runTime() + " min"
            self.lbRated.text = "Avaliação: " + self.model.rated()
            self.lbOverview.text = self.model.plot()
            self.navigationItem.title = self.model.title()
            hud.dismiss()
        }
    }
    


}
