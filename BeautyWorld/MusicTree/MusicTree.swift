//
//  MusicTree.swift
//  BeautyWorld
//
//  Created by CGLab on 2017/6/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class MusicTree: SCNNode {
    override init(){
        super.init()
        let box = SCNBox(width: 0.2, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = box
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
