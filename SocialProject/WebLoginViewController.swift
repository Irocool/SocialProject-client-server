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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
