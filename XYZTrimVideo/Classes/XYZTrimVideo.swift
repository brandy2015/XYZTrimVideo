//
//  XYZTrimVideo.swift
//  XYZTrimVideo
//
//  Created by 张子豪 on 2019/1/5.
//  Copyright © 2019 张子豪. All rights reserved.
//
//需要
//#import "YGCTrimVideoView.h"

import UIKit
import Photos

class XYZTrimVideo: NSObject,YGCTrimVideoViewDelegate {
    
    static var shared = XYZTrimVideo()
    static var superView = UIView()
    
    
    var ygcTrimView = YGCTrimVideoView()
    var player : AVPlayer?
    var originItem : AVPlayerItem!
    var playerItem : AVPlayerItem!
    var playerLayer = AVPlayerLayer()
    
    
    
    init(URLX :URL? = nil) {
        
        
        
        super.init()
        
        var asset : AVURLAsset!
        var pathurl : URL!
        if let URLX = URLX{
            asset = AVURLAsset(url: URLX)
            pathurl = URLX
        }else{
            let path = Bundle.main.path(forResource: "zuxian", ofType: "MP4")!
            pathurl = URL(fileURLWithPath: path)
            asset = AVURLAsset(url: pathurl)
        }
        
        
        
         originItem = AVPlayerItem(asset: asset)
         player = AVPlayer(playerItem:  originItem)
         playerLayer = AVPlayerLayer(player:  player)
        
        
        let x = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 75 - 40, width:UIScreen.main.bounds.size.width, height: 75)
        
        ygcTrimView = YGCTrimVideoView(frame: x, assetURL: pathurl)
        ygcTrimView.delegate = self
        ygcTrimView.maxSeconds = 18
//        ygcTrimVie
        
    }
    
    
    func videoBeginTimeChanged(_ begin: CMTime) {
        if self.player?.currentItem != self.originItem{
            
            self.player?.replaceCurrentItem(with: self.originItem)
            
        }
        
        self.player?.seek(to: begin) { (finished) in
            print(finished)
        }
        
        
    }
    
    func videoEndTimeChanged(_ end: CMTime) {
        if self.player?.currentItem != self.originItem{
            
            self.player?.replaceCurrentItem(with: self.originItem)
            
        }
        
        self.player?.seek(to: end) { (finished) in
            print(finished)
        }
        
    }
    
    func dragActionEnded(_ asset: AVMutableComposition!) {
        self.playerItem = AVPlayerItem(asset: asset)
        
        self.player?.replaceCurrentItem(with: self.playerItem)
        self.player?.play()
        
    }
    
    func generatorVideoFun(successX: @escaping ()->Void,failedX: @escaping ()->Void)  {
        
        self.ygcTrimView.exportVideo { (success, outputURL) in
            if success{
                PHPhotoLibrary.shared().performChanges({
                    
                    if let outputURL = outputURL{
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputURL)
                    }else{
                        print("错误URL不存在")
                    }
                    
                }, completionHandler: { (success, error) in
                    
                    if success{
                        successX()
                    }else{
                        failedX()
                        print(error as Any)
                    }
                    
                    
                })
                
            }
        }
    }
    
    func play()  {
        
        
            player?.play()
        if player?.rate == 0 {
            player?.seek(to: CMTime.zero)
            player?.play()
        }
        
    }
    func pause()  {
        player?.pause()
    }
    func stop()  {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
    func isPlaying() -> Bool {
        
        
        if  player?.rate == 0{
            return false
        }else{
            return true
        }
        
    }
    
}
