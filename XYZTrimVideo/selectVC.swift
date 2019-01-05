//
//  selectVC.swift
//  XYZTrimVideo
//
//  Created by 张子豪 on 2019/1/5.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
class selectVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func 选择视频BTN(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie] as [String]
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func demoBTN(_ sender: Any) {
        
        XYZTrimVideo.shared = XYZTrimVideo()
        
        
        PresentNAV(id: "TrimVideoVCID")
        
        
    }
    
    public func PresentNAV(id:String?) {
        let mainSB: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let id = id{
            let NAV = mainSB.instantiateViewController(withIdentifier: id)
            self.present(NAV, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      print(info)
        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            print("在这里")
            print(url)
            
            
            
            XYZTrimVideo.shared = XYZTrimVideo(URLX: url)
        }else{
            print("没东西")
        }
        picker.dismiss(animated: true) {
            self.PresentNAV(id: "TrimVideoVCID")
        }
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
