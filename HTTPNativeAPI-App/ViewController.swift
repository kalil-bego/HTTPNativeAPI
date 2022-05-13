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
    private var server = ServerManager(port: 8080, baseURL: "/periferico")

    override func viewDidLoad() {
        super.viewDidLoad()
        server.start { serverURL in
            let request: URLRequest = .init(url: serverURL)
            self.webView.load(request)
        } failure: { error in
            print(error ?? "")
        }
        
        server.addEndpoint(.init(path: "/TesteA"))
        server.addEndpoint(.init(path: "/TesteB"))
        server.getEndpoints().forEach { endpoint in
            print(endpoint)
        }
    }

}

