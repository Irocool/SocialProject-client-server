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
    private let appID = ""
    private let versionAPI = "5.126"
    private let scope = "336902"
    private let redirectURI = "https://oauth.vk.com/blank.html"
    private let responseURLpath = "/blank.html"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        guard let url = navigationResponse.response.url, url.path == responseURLpath, let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
     //   let params = fragment
     //       .components(separatedBy: "&")
     //       .map { $0.components(separatedBy: "=") }
     //       .reduce([String: String]()) { result, param in
     //           var dict = result
     //           let key = param[0]
     //          let value = param[1]
     //           dict[key] = value
     //           return dict
     //       }
        
        //let token = params["access_token"]
       // let userID = params["user_id"]
        
    }
}
