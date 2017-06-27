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
import AudioKit

class MusicTree: SCNNode {
    
    var musicFile: AKAudioFile!
    var musicPlayer: AKAudioPlayer!
    var trackedAmplitude: AKAmplitudeTracker!
    var amplitude: Float = 0
    var box: SCNBox?
    
    override init(){
        super.init()
        
        do{
            let path = Bundle.main.path(forResource: "Sample.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            musicFile = try AKAudioFile(forReading: url)
            musicPlayer = try AKAudioPlayer(file: musicFile)
            trackedAmplitude = AKAmplitudeTracker(musicPlayer)
            AudioKit.output = trackedAmplitude
            //musicPlayer.start()
        }catch{
            print(error)
        }
        
        box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = box
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func play(){
        AudioKit.start()
        musicPlayer.play()
        AKPlaygroundLoop(every: 0.1) {
            self.amplitude = (Float)(self.trackedAmplitude.amplitude)
            self.transform = SCNMatrix4MakeRotation(-Float.pi / 2, self.amplitude, 0, 0)
            print(self.position)
        }
    }
    
    func stop(){
        // AudioKit.stop()
        // will cause AKPlayergroundLoop error?
        musicPlayer.stop()
    }
    
    override func treeRefresh(){
        //self.transform = SCNMatrix4MakeRotation(-Float.pi / 2, self.amplitude, 0, 0)
        box = SCNBox(width: CGFloat(0.1 * self.amplitude), height: CGFloat(0.1 * self.amplitude), length: CGFloat(0.1 * self.amplitude), chamferRadius: 0)
        print(box)
    }
}
