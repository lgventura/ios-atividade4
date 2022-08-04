//
//  atividade.swift
//  IOS-Atividade4
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

enum atividade4Type {
  case normal
  case fire
  case water
  case electric
  case grass
  case ice
  case fighting
  case poison
  case ground
  case flying
  case psychic
  case bug
  case rock
  case ghost
  case dragon
  case dark
  case steel
  case fairy
}

class atividade: NSObject {
  let name: String
  let id: Int
  let detailInfo: String
  let type: [atividade4Type]
  let weak: [atividade4Type]
  let atividade4ImgUrl: String
  
  init(name: String, id: Int, detailInfo: String, type: [atividade4Type], weak: [atividade4Type], atividade4ImgUrl: String) {
    self.name = name
    self.id = id
    self.detailInfo = detailInfo
    self.type = type
    self.weak = weak
    self.atividade4ImgUrl = atividade4ImgUrl
  }
}
