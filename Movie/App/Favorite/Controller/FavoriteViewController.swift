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
    
    
    var model: FavoriteViewModel!
    var label = UILabel()
    
    static func instantiate(viewModel: FavoriteViewModel) -> FavoriteViewController {
        let favoriteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        favoriteViewController.model = viewModel
        
        return favoriteViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favoritos"
        label.text = "Você ainda não possui filmes salvos"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setBackGround()
        self.collect.delegate = self
        self.collect.dataSource = self
        model.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        model.getAll()
        collect.backgroundView = model.numberOfRows() == 0 ? label : nil
    }
    
    
}

extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfRows()        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "fav", for: indexPath) as! FavoriteViewCell
        cell.posterImage.image = model.result[indexPath.row].poster_path as! UIImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = Int(model.result[indexPath.row].id!)
        model.selectMovie(id: id!)
    }
    
}


extension FavoriteViewController: FavoriteViewModelDelegate {
	
    func alertReloadData(title: String, message: String) {
        genericAlert(title: title, message: message)
    }
    
    
    func reloadData() {
        self.collect.reloadData()
    }
    
}
