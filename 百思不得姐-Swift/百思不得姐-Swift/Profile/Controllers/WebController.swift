//
//  WebController.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit
import WebKit

class WebController: UIViewController {
    
    var webView:WKWebView!
    
    
    var url:String! {
    
        didSet {
            SVProgressHUD.show()
            let webview = WKWebView(frame: view.bounds)
            
            webview.backgroundColor = ConstTool.instance.GlobalColor()
            webview.uiDelegate = self
            webview.navigationDelegate = self
            view.addSubview(webview)
            webView = webview

            let Url = URL(string: url)
            
            let request = URLRequest(url: Url!)
            
            webView.load(request)
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension WebController:WKNavigationDelegate,WKUIDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.showError(withStatus: "加载失败,请稍后重试")
    }
}
