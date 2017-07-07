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
import AVFoundation

class MusicTree: SCNNode {
    
    var musicFile: AKAudioFile!
    var musicPlayer: AKAudioPlayer!
    var trackedAmplitude: AKAmplitudeTracker!
    var amplitude: Float = 0
    
    override init(){
        super.init()
         
        do{
            let path = Bundle.main.path(forResource: "Sample.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            musicFile = try AKAudioFile(forReading: url)
            musicPlayer = try AKAudioPlayer(file: musicFile)
            musicPlayer.looping = false
            trackedAmplitude = AKAmplitudeTracker(musicPlayer)
            
            let mixer = AKMixer(musicPlayer, trackedAmplitude)
            AudioKit.output = mixer
            AudioKit.start()
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            
        }catch{
            print(error)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func play(){
        
        musicPlayer.play(from:0.0, to:10.0)
        trackedAmplitude.start()
        AKPlaygroundLoop(every: 1) {
            //print(fft.fftData.count)
            self.amplitude = (Float)(self.trackedAmplitude.amplitude)
            self.transformWithMusic()
            //print(self.position)
        }
        
        
    }
    
    func stop(){
        
        //AudioKit.stop()
        // will cause AKPlayergroundLoop error?
        musicPlayer.stop()
        trackedAmplitude.stop()
        
    }
    
    var isOdd: Bool = false
    var branchNumInLastLayer: Int = 1
    var branchNumInLayer: Int = 3
    var branchsTopPosition = [SCNVector3(0,0,0)]
    var LayerIndex: Int = 0
    
    func transformWithMusic(){
        //self.transform = SCNMatrix4MakeRotation(-Float.pi / 2, self.amplitude, 0, 0)
        let branchHeight = CGFloat(0.5 * self.amplitude)
        print("Layer:", LayerIndex)
        print("branchsTopPositionCount:",branchsTopPosition.count)
        print("BranchNumInLayer:", branchNumInLayer)
        print("BranchNumInLastLayer:", branchNumInLastLayer)
        let newbranch = branchNode(height: branchHeight, bottomPosition: branchsTopPosition[branchNumInLayer % branchNumInLastLayer])
        branchsTopPosition.append(newbranch.topPosition!)
        self.addChildNode(newbranch)
        branchNumInLayer -= 1
        if branchNumInLayer <= 0 {
            print("----- New Layer -----")
            LayerIndex += 1
            branchsTopPosition.removeSubrange(0...branchNumInLastLayer-1)
            branchNumInLastLayer = branchsTopPosition.count
            branchNumInLayer = Int(random(3.0,8.0))
            print("This layer's bottom position:",branchsTopPosition)
        }
        /*
        box?.height = CGFloat(0.5 * self.amplitude)
        let color = UIColor(colorLiteralRed: 0.2, green: 0.8, blue: 0.8, alpha: 0.8)
        box?.firstMaterial?.diffuse.contents = color
        position.y = 0
        */
        
    }
}

class branchNode: SCNNode{
    
    public var topPosition: SCNVector3?
    public var bottomPosition: SCNVector3?
    //public var rotation = [Double]()
    
    var box: SCNBox?
    
    init(height: CGFloat,bottomPosition: SCNVector3){
        super.init()
        box = SCNBox(width: 0.01, height: height, length: 0.01, chamferRadius: 0)
        let color = UIColor(colorLiteralRed: 0.2, green: 0.8, blue: Float(random(0.5, 0.9)), alpha: 0.8)
        box?.firstMaterial?.diffuse.contents = color
        self.geometry = box
        //self.rotation = SCNVector4(1,1,0,random(-0.3*3.14, 0.3*3.14))
        self.position = bottomPosition + SCNVector3(0,0,height/2)
        self.topPosition = bottomPosition + SCNVector3(0,0,height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
