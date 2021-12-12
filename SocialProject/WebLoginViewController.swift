//
//  WebLoginViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 21.11.2021.
//

import UIKit
import WebKit

class WebLoginViewController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var webKitView: WKWebView!{
        didSet{
            webKitView.navigationDelegate = self
        }
    }
  
    private let appID = "8006756"
    private let versionAPI = "5.131"
    private let scope = "336902"
    private let redirectURI = "https://oauth.vk.com/blank.html"
    private let responseURLpath = "/blank.html"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadVKauthorization()
    }
    
    func loadVKauthorization() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: appID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: versionAPI)
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webKitView.load(request)
    }
    

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == responseURLpath, let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
           .reduce([String: String]()) { result, param in
               var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
           }
        
        let token = params["access_token"]
        let userID = params["user_id"]
        print(token as Any)
   // let token = "1ccafc2ebc953cef0a327ac45b1676715b2012d1eee2dd2f25e66a9b85d1dbc0818fe9b115632450dd047"
   // let userID = "318890740"
    
        // MARK: - Saving token and userID to UserSession
        UserSession.instance.token = token
        UserSession.instance.userID = Int(userID ?? "")
        
        decisionHandler(.cancel)
        
        if UserSession.instance.token != nil,
           UserSession.instance.userID != nil {
            //moveToTabBarController()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as! TabBarController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        } else {
            // TODO: - Do something if didn't get token
        }
    
    
    // MARK: - Move to TabBarController after success authorization
     func moveToTabBarController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as! TabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
     }
    
}
}
