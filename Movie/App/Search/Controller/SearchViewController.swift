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
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Use barra de procura para encontrar filmes"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collect.dataSource = self
        collect.delegate = self
        searchBar.delegate = self
        model = SearchViewModel(service: Service())
        self.model.delegate = self
        presentText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func presentText(){
        collect.reloadData()
        collect.backgroundView = model.numberOfRows() == 0 ? label : nil
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfRows()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "search", for: indexPath) as! SearchCell
        cell.drawCell(url: model.cellImageAtIndexPath(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.model.returnID(indexPath: indexPath)
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        view.model = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: false)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            model.cleanMovies()
            label.text = "Use barra de procura para encontrar filmes"
            presentText()
        } else {
            model.getMoviesWithTitleService(title: searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offSetY > contentHeight - scrollView.frame.height {
            model.pagination(title: self.searchBar.text!)
        }
    }
}


extension SearchViewController: SearchViewModelDelegate {
    func responseSuccess() {
        if model.movies.isEmpty {
            model.cleanMovies()
            self.label.text = "Não foi possivel encontrar filme"
        } else {
            presentText()
        }
    }
    
    func responseError() {
        label.text = "Falha ao procurar filmes"
        presentText()
    }    
}
