//
//  SearchViewController.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collect: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var model: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collect.dataSource = self
        collect.delegate = self
        searchBar.delegate = self
        model = SearchViewModel(service: Service())
    }

}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "search", for: indexPath) as! SearchCell
        cell.drawCell(url: model.cellImageAtIndexPath(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.model.returnID(indexPath: indexPath)
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        view.model = InfoViewModel(id: id, service: Service())
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        model.getMoviesWithTitleService(title: searchBar.text!) { () in
            self.collect.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offSetY > contentHeight - scrollView.frame.height {
            model.pagination(title: self.searchBar.text!) { () in
                self.collect.reloadData()
            }
            
        }
    }
}
