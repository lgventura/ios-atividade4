//
//  LibraryAPI.swift
//  IOS-Atividade4
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
  static let sharedInstance = LibraryAPI()
  let persistencyManager = PersistencyManager()
  
  fileprivate override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: NSNotification.Name(rawValue: downloadImageNotification), object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func getatividades() -> [atividade] {
    return atividades
  }
  
  func downloadImg(_ url: String) -> (UIImage) {
    let aUrl = URL(string: url)
    let data = try? Data(contentsOf: aUrl!)
    let image = UIImage(data: data!)
    return image!
  }
  
  func downloadImage(_ notification: Notification) {
    // retrieve info from notification
    let userInfo = (notification as NSNotification).userInfo as! [String: AnyObject]
    let atividade4ImageView = userInfo["atividade4ImageView"] as! UIImageView?
    let atividade4ImageUrl = userInfo["atividade4ImageUrl"] as! String
    
    if let imageViewUnWrapped = atividade4ImageView {
      imageViewUnWrapped.image = persistencyManager.getImage(URL(string: atividade4ImageUrl)!.lastPathComponent)
      if imageViewUnWrapped.image == nil {
        
        DispatchQueue.global().async {
          let downloadedImage = self.downloadImg(atividade4ImageUrl as String)
          DispatchQueue.main.async {
            imageViewUnWrapped.image = downloadedImage
            self.persistencyManager.saveImage(downloadedImage, filename: URL(string: atividade4ImageUrl)!.lastPathComponent)
          }
        }
      }
    }
  }
}
