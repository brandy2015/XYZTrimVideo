//
//  ViewController.swift
//  XYZTrimVideo
//
//  Created by 张子豪 on 2019/1/4.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit
import Photos

class TrimVideoVC: UIViewController {
    @IBOutlet weak var previewContainer: UIView!
    
    
    @IBAction func 关闭BTN(_ sender: Any) {
        XYZTrimVideo.shared.stop()
        XYZTrimVideo.shared.player = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ExportBTN(_ sender: Any) {
        XYZTrimVideo.shared.generatorVideoFun(successX: {
            print("生成成功")
            
            XYZTrimVideo.shared.stop()
            XYZTrimVideo.shared.player = nil
            self.dismiss(animated: true, completion: nil)
        }) {
            XYZTrimVideo.shared.stop()
            XYZTrimVideo.shared.player = nil
            print("生成失败")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func playBTN(_ sender: Any) {
        print("点按了")
        if XYZTrimVideo.shared.isPlaying(){
            XYZTrimVideo.shared.pause()
             print("点按了pause")
        }else{
            XYZTrimVideo.shared.play()
             print("点按了play")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.previewContainer.layer.addSublayer(XYZTrimVideo.shared.playerLayer)
        self.view.addSubview(XYZTrimVideo.shared.ygcTrimView)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        XYZTrimVideo.shared.play()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        XYZTrimVideo.shared.playerLayer.frame = self.previewContainer.bounds
    }
//    mark - Delegate
}
