//
//  SearchViewController.swift
//  Space
//
//  Created by lina on 2021/11/13.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        cell.configuerCell(imageURL: "", name: "\(indexPath)")
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
}
