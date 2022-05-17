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
    private var server = ServerManager(port: 8080, contextPath: "/periferico")

    override func viewDidLoad() {
        super.viewDidLoad()
        server.addEndpoint(GetTestEndpoint())
        server.addEndpoint(PostTestEndpoint())

        server.start(
            success: serverStarted(_:),
            failure: serverFailure(_:)
        )

        server.getEndpoints().forEach { endpoint in
            print(endpoint.path)
        }
    }
    
    private func serverStarted(_ url: URL) {
        let request: URLRequest = .init(url: url)
        self.webView.load(request)
    }
    
    private func serverFailure(_ error: Error?) {
        let okAction: UIAlertAction = .init(title: "Ok", style: .cancel)
        let alertViewController: UIAlertController = createAlert(title: "Error",
                                                                 message: error?.localizedDescription,
                                                                 actions: [okAction])
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true)
        }
    }
    
    private func createAlert(title: String, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let alertViewController: UIAlertController = .init(title: title,
                                                           message: message,
                                                           preferredStyle: .alert)
        actions.forEach { alertViewController.addAction($0) }
        return alertViewController
    }

}

