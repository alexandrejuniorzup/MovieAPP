//
//  PopularCell.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//


import UIKit
import SDWebImage

class PopularCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ivPoster: UIImageView!

    func drawCell(url: String){
        if url == "" {
            self.ivPoster.image = UIImage(named: "notFound")
        } else {
            self.ivPoster.sd_setImage(with: URL(string: url)!, completed: nil)
        }
    }
}
