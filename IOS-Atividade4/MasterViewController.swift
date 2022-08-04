//
//  MasterViewControllerTableViewController.swift
//  IOS-Atividade4
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol atividadeSelectionDelegate: class {
  func atividadeSelected(_ newatividade: atividade)
}

class MasterViewController: UITableViewController {
  var atividades = LibraryAPI.sharedInstance.getatividades()
  var filteredatividades = [atividade]()
  weak var delegate: atividadeSelectionDelegate?
  
  fileprivate let disposeBag = DisposeBag()
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    filteredatividades = atividades
  }
  
  fileprivate func setupUI() {
    self.title = "精灵列表"
    
    definesPresentationContext = true
    
    searchBar
      .rx.text
      .throttle(0.5, scheduler: MainScheduler.instance)
      .subscribe(
        onNext: { [unowned self] query in
          if query?.characters.count == 0 {
            self.filteredatividades = self.atividades
          } else {
            self.filteredatividades = self.atividades.filter{ $0.name.hasPrefix(query!) }
          }
          self.tableView.reloadData()
        })
      .addDisposableTo(disposeBag)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let atividade = self.filteredatividades[(indexPath as NSIndexPath).row]

    delegate?.atividadeSelected(atividade)
    
    if let detailViewController = self.delegate as? DetailViewController {
      splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
    }
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredatividades.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = "Cell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MasterTableViewCell
    let atividade = filteredatividades[(indexPath as NSIndexPath).row]
    
    cell.awakeFromNib(atividade.id, name: atividade.name, atividade4ImageUrl: atividade.atividade4ImgUrl)
    
    return cell
  }
}
