//
//  MasterTableViewCell.swift
//  IOS-Atividade4
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var atividade4ImageView: UIImageView!
  
  fileprivate var indicator: UIActivityIndicatorView!
  
  func awakeFromNib(_ id: Int, name: String, atividade4ImageUrl: String) {
    super.awakeFromNib()
    setupUI(id, name: name)
    setupNotification(atividade4ImageUrl)
  }
  
  deinit {
    atividade4ImageView.removeObserver(self, forKeyPath: "image")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  fileprivate func setupUI(_ id: Int, name: String) {
    idLabel.text = NSString(format: "#%03d", id) as String
    nameLabel.text = name
    atividade4ImageView.image = UIImage(named: "default_img")
    
    indicator = UIActivityIndicatorView()
    indicator.center = CGPoint(x: atividade4ImageView.bounds.midX, y: atividade4ImageView.bounds.midY)
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.startAnimating()
    atividade4ImageView.addSubview(indicator)
    
    atividade4ImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
  }
  
  fileprivate func setupNotification(_ atividade4ImageUrl: String) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: downloadImageNotification), object: self, userInfo: ["atividade4ImageView":atividade4ImageView, "atividade4ImageUrl" : atividade4ImageUrl])
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "image" {
      indicator.stopAnimating()
    }
  }
}
