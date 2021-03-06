//
//  LoginViewController.swift
//  QiitaReader
//
//  Created by Takuya Matsuda on 2018/04/23.
//  Copyright © 2018年 mycompany. All rights reserved.
//

import UIKit
import TOWebViewController

class LoginViewController: TOWebViewController {
    var webview: UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.webview.frame = self.view.bounds
        self.webview.delegate = self;
        self.view.addSubview(self.webview)
        
        let url = NSURL(string: "https://qiita.com/login?redirect_to=%2F")
        let request = NSURLRequest(url: url! as URL)
        self.webview.loadRequest(request as URLRequest)
    }
    
    
    override func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
