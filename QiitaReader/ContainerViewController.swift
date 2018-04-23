//
//  ContainerViewController.swift
//  QiitaReader
//
//  Created by Takuya Matsuda on 2018/04/16.
//  Copyright © 2018年 mycompany. All rights reserved.
//

import UIKit
import Alamofire

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TODO -
        // loginのチェック
        // login済みの処理
            // TrendVC表示
        // loginしてない時の処理
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /////////////////////////////////////////////////////////////////////
    
    //子のViewControllerを追加する
    func displayContentController(content: UIViewController) {
    // 自身のビューコントローラ階層に追加
    // 自動的に子ViewControllerの`willMoveToParentViewController:`メソッドが呼ばれる
    self.addChildViewController(content)
    // 子ViewControllerの`view`を自身の`view`階層に追加
    self.view.addSubview(content.view)
    // 子ViewControllerに追加が終わったことを通知する
    content.didMove(toParentViewController: self)
    }
    
    
    
    //子のViewControllerを削除する
    func hideContentController(content: UIViewController) {
    // これから取り除かれようとしていることを通知する（引数が`nil`なことに注意）
    content.willMove(toParentViewController: nil)
    // 子ViewControllerの`view`を取り除く
    content.view.removeFromSuperview()
    // 子ViewControllerを取り除く
    // 自動的に`didMoveToParentViewController:`が呼ばれる
    content.removeFromParentViewController()
    }
    

    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}