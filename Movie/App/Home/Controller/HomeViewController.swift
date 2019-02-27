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
        setBackGround()
        self.collectPo.delegate = self
        self.collectPo.dataSource = self
        self.collectRa.delegate = self
        self.collectRa.dataSource = self
        self.collectUp.delegate = self
        self.collectUp.dataSource = self
        model = HomeViewModel(service: Service())
        model.delegate = self
        model.getPo() { () in
            self.collectPo.reloadData()
        }
        model.getRa {
            self.collectRa.reloadData()
        }
        model.getUp {
            self.collectUp.reloadData()
        }
        self.model.timerDestaque()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    
    @IBAction func destaqueInfo(_ sender: Any) {
        if !verifyConnection(){
            alertNoConnection()
        } else {
            let id = self.model.destaque!
            let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            view.model = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: false)
            self.navigationController?.pushViewController(view, animated: true)
        }
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
        if verifyConnection(){
            if collectionView == collectPo{
                let id = self.model.returnID(type: CollectType.popular, indexPath: indexPath)
                let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                view.model = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: false)
                self.navigationController?.pushViewController(view, animated: true)
            } else if collectionView == collectRa{
                let id = self.model.returnID(type: CollectType.rated, indexPath: indexPath)
                let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                view.model = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: false)
                self.navigationController?.pushViewController(view, animated: true)
            } else if collectionView == collectUp{
                let id = self.model.returnID(type: CollectType.upcoming, indexPath: indexPath)
                let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                view.model = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: false)
                self.navigationController?.pushViewController(view, animated: true)
            }
        }else {
            alertNoConnection()
        }
    }
}


extension HomeViewController : HomeViewModelDelegate{
    func didChange(url: URL) {
        self.ivPoster.sd_setImage(with: url, completed: nil)
    }
}
