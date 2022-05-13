//
//  ViewController.swift
//  Sample API
//
//  Created by Kalil Bego on 12/05/22.
//

import UIKit
import WebKit
import HTTPNativeAPI

final class ViewController: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    private let server = ServerManager(port: 8080)

    override func viewDidLoad() {
        super.viewDidLoad()
        server.start { serverURL in
            self.webView.load(URLRequest(url: serverURL ?? URL(fileURLWithPath: "")))
        }
    }

}

