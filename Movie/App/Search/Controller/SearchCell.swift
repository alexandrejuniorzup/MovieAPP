//
//  SearchCell.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    func drawCell(url: String){
        if url == "" {
            self.posterImage.image = UIImage(named: "notFound")
        } else {
            self.posterImage.sd_setImage(with: URL(string: url)!, completed: nil)
        }
    }
    
}