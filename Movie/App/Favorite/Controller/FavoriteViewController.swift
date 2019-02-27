//
//  FavoriteViewController.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 27/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collect: UICollectionView!
    
    var model:FavoriteViewModel!
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Você ainda não possui filmes salvos"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setBackGround()
        self.collect.delegate = self
        self.collect.dataSource = self
        self.model = FavoriteViewModel(database: Database())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        model.getAll() { () in
            self.collect.reloadData()
        }
        
    }
    

}

extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count  = model.numberOfRows()
        collectionView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "fav", for: indexPath) as! FavoriteViewCell
        cell.ivPoster.image = model.result[indexPath.row].poster_path as! UIImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = Int(model.result[indexPath.row].id!)
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        view.model = InfoViewModel(id: id!, service: Service(), database: Database(), fromDatabase: true)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
