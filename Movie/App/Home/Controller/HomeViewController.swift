//
//  HomeViewController.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    private var model: HomeViewModel!
    
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var collectPo: UICollectionView!
    @IBOutlet weak var collectRa: UICollectionView!
    @IBOutlet weak var collectUp: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectPo.delegate = self
        self.collectPo.dataSource = self
        self.collectRa.delegate = self
        self.collectRa.dataSource = self
        self.collectUp.delegate = self
        self.collectUp.dataSource = self
        
        model = HomeViewModel(service: Service())
        model.getPo() { () in
            self.collectPo.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.collectPo.reloadData()
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfMoviesInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectPo.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as! PopularCell
        cell.ivPoster.sd_setImage(with: URL(string: model.getImage(indexPath: indexPath)), completed: nil)
        return cell
    }
    
    
}
