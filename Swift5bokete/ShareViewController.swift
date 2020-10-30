//
//  ShareViewController.swift
//  Swift5bokete
//
//  Created by 山﨑隼汰 on 2020/10/30.
//

import UIKit

class ShareViewController: UIViewController {

    //viewcontrollerのデータと受け取る箱を宣言
    var resultImage = UIImage()
    var commentString = String()
    //スクリーンショット入れる入れ物
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var commentLavel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //遷移してきたデータを表示する
        resultImageView.image = resultImage
        commentLavel.text = commentString
      
        //コメントが入るように調節する機能
        commentLavel.adjustsFontSizeToFitWidth = true
        
    
    }
    

    @IBAction func share(_ sender: Any) {
    
    //スクリーンショットを撮る
        takeScreenShot()
      
    //スクリーンショットイメージをAny型にキャスト
     let items = [screenShotImage] as [Any]
        
    // アクティビティビューに乗っけて、シェアする
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
    
     present(activityVC, animated: true, completion: nil)
        
    }
    
    //スクリーンショットを撮影するfunctionを宣言(脳死でok)
    func takeScreenShot() {
 
    let width = CGFloat(UIScreen.main.bounds.size.width)
    let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
    let size = CGSize(width: width, height: height)
    
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
    }
    
    //モーダルで遷移しているのでdismissで戻れる
    
    @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
    
    
    }
    
}
