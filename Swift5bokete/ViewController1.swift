//
//  ViewController1.swift
//  Swift5bokete
//
//  Created by 山﨑隼汰 on 2020/10/30.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController1: UIViewController {

    
    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //テキストビューの角を丸くする
        commentTextView.layer.cornerRadius = 20.0
       
        //アルバムの使用許可を出す //クロージャー
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
            case .authorized: break
            case .denied: break
            case .notDetermined: break
            case .restricted: break
            case .limited: break
                          
           
            }
        }
           
         //ビューが読まれた時に画像を取得する
      getImages(keyword: "funny")
       
        }
       
    
    
//検索キーワードの値を元に画像をひっぱてくる //ここ重要！！
    func getImages(keyword:String) {
        
  
        //APYKEY　間違えやすいので注意！！
        let url = "https://pixabay.com/api/?key=15853135-3e1af0294e6438294e606e75e&q=\(keyword)"
        
        //Alamofireを使ってhttpリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default) .responseJSON { (response) in
        
            switch response.result{
            
            case .success:
                //データを取得して、jsonの箱に入っている
                let json:JSON = JSON(response.data as Any)
                //取得したいデータを書く
                var imageStirng = json["hits"][self.count]["webformatURL"].string //selfがつくのはクロージャーの中だから
              
                //取得するデータがない場合カウントを0に戻す
                if imageStirng == nil {
                    
                    imageStirng = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with:URL(string: imageStirng!) , completed: nil)
                
                }else{
                
                //SDWebImageを使用する //imageStirngは確定した値が入っていないのでキャストする
                //取得したurlをodaiImageViewにセットしている(sdwebイメージのメソッドを使用している)
                self.odaiImageView.sd_setImage(with:URL(string: imageStirng!) , completed: nil)
                
                }
                
                //失敗した場合エラーを返す
                case .failure(let error):
                print(error)
                
                }
            
            
            
            
        }
            
        }
        
    @IBAction func nextodai(_ sender: Any) {
  
        count = count + 1
        
        if searchTextField.text == "" {
            getImages(keyword: "woman")
            
            
        }else{
            
            getImages(keyword: searchTextField.text!)
            
            
            
        }
    
    

    }
    
    @IBAction func seachAction(_ sender: Any) {
       
        //サーチの時は、カウントが0になっていないと、let imageStirng = json["hits"][self.count]["webformatURL"].stringが最初から呼ばれない
        self.count = 0
        
        if searchTextField.text == "" {
            getImages(keyword: "woman")
            
            
        }else{
            
            getImages(keyword: searchTextField.text!)
            
            
            
        }
    
    
    }
    
    //画面遷移
    @IBAction func nect(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
        
        
        
    }
    
    //shareVCに値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
        
        
    }
    
}
   

