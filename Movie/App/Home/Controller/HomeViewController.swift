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
    
    static func instantiate(viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.model = viewModel
        return homeViewController
    }
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var collectPo: UICollectionView!
    @IBOutlet weak var collectRa: UICollectionView!
    @IBOutlet weak var collectUp: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Top Rated"
        setBackGround()
        self.collectPo.delegate = self
        self.collectPo.dataSource = self
        self.collectRa.delegate = self
        self.collectRa.dataSource = self
        self.collectUp.delegate = self
        self.collectUp.dataSource = self
        model.delegate = self
        model.getPopular() { () in
            self.collectPo.reloadData()
        }
        model.getRated {
            self.collectRa.reloadData()
        }
        model.getUpcoming {
            self.collectUp.reloadData()
        }
        self.model.timerDestaque()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    
    @IBAction func destaqueInfo(_ sender: Any) {
        let id = self.model.destaque!
        model.selectMovie(id: id)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfMoviesInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectPo {
            let cell = collectPo.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as! PopularCell
            cell.drawCell(url: model.getImage(indexPath: indexPath, type: CollectType.popular))
            return cell
            
        } else if collectionView == collectRa {
            let cell = collectRa.dequeueReusableCell(withReuseIdentifier: "rated", for: indexPath) as! RatedCell
            cell.drawCell(url: model.getImage(indexPath: indexPath, type: CollectType.rated))
            return cell
            
            
        } else {
            let cell = collectUp.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingCell
            cell.drawCell(url: model.getImage(indexPath: indexPath, type: CollectType.upcoming))
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectPo{
            let id = self.model.returnID(type: CollectType.popular, indexPath: indexPath)
            model.selectMovie(id: id)
        } else if collectionView == collectRa{
            let id = self.model.returnID(type: CollectType.rated, indexPath: indexPath)
            model.selectMovie(id: id)
        } else if collectionView == collectUp{
            let id = self.model.returnID(type: CollectType.upcoming, indexPath: indexPath)
            model.selectMovie(id: id)
        }
    }
}


extension HomeViewController : HomeViewModelDelegate{
    
    func didChange(url: URL) {
        self.posterImage.sd_setImage(with: url, completed: nil)
    }
    
    func presentErrorConnection() {
        alertNoConnection()
    }
    
}
