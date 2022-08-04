//
//  DetailViewController.swift
//  IOS-Atividade4
//
//  Created by Yi Gu on 7/13/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var nameIDLabel: UILabel!
  @IBOutlet weak var atividade4ImageView: UIImageView!
  @IBOutlet weak var atividade4InfoLabel: UILabel!
  
  var atividade: atividade! {
    didSet (newatividade) {
      self.refreshUI()
    }
  }
  
  override func viewDidLoad() {
    refreshUI()
    super.viewDidLoad()
    
  }
  
  func refreshUI() {
    nameIDLabel?.text = atividade.name + (atividade.id < 10 ? " #00\(atividade.id)" : atividade.id < 100 ? " #0\(atividade.id)" : " #\(atividade.id)")
    atividade4ImageView?.image = LibraryAPI.sharedInstance.downloadImg(atividade.atividade4ImgUrl)
    atividade4InfoLabel?.text = atividade.detailInfo
    
    self.title = atividade.name
  }
}

extension DetailViewController: atividadeSelectionDelegate {
  func atividadeSelected(_ newatividade: atividade) {
    atividade = newatividade
  }
}
