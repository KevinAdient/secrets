//
//  ViewController.swift
//  Project4
//
//  Created by Peter M. Gits.
//  Copyright © 2017 Adient. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView!
	var progressView: UIProgressView!

    var websites = ["biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w"]

//    var websites = ["agsm.adient.com/siteminderagent/forms/ag_primary.fcc?TYPE=33554433&amp;REALMOID=06-ee9a9733-4a38-4ee7-95c9-7fe1801058c2&amp;GUID=&amp;SMAUTHREASON=0&amp;METHOD=GET&amp;SMAGENTNAME=8yUsyDSZUFV1o873Kdzm1dYMiJFJF9ekwOP8E9bnkUGqJ5Nn4Wg6ke9iIkL8xSYH&amp;TARGET=-SM-HTTPS%3a%2f%2fbiprod%2eadient%2ecom%2fBOE%2fOpenDocument%2fopendoc%2fopenDocument%2ejsp%3fsIDType%3dCUID%26iDocID%3dATahFNnVW6FPiU5PkY6NW9w", "biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w", "apple.com", "hackingwithswift.com"]

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

    func do_cookies(_ originalRequest:URLRequest)->URLRequest {
        var request:URLRequest = originalRequest
        let validDomain:NSString = request.url!.host! as NSString
        let requestIsSecure:Bool = (request.url!.scheme == "https" as String?)
    
        var array:NSMutableArray = NSMutableArray()
        if let cookies = HTTPCookieStorage.shared.cookies {
          for cookie in cookies {
            // Don't even bother with values containing a `'`
                print(cookie)
            if cookie.name.range(of: "'") != nil {
                
                NSLog("Skipping \(String(describing: cookie.properties)) because it contains a '")
                continue;
            }
    
            // Is the cookie for current domain?
            if (!cookie.domain.hasSuffix(validDomain as String)) {
                NSLog("Skipping \(String(describing: cookie.properties)) (because not \(validDomain))\n")
                continue;
            }
    
            // Are we secure only?
            if (cookie.isSecure && !requestIsSecure) {
                NSLog("Skipping \(String(describing: cookie.properties)) (because \(String(describing: request.url?.absoluteString)) not secure)\n")
                continue;
            }
    
            let value:String = String(format:"%@=%@", cookie.name, cookie.value)
            print(String(format:"cookie name = %@, value = %@", cookie.name, cookie.value))
            array.add(value)
            }
        }
    
        let header = array.componentsJoined(by:";")
        request.setValue(header, forHTTPHeaderField:"Cookie")
        return request;
    }

    override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let theUrl = URL(string:"https://" + websites[0])
        var myRequest:URLRequest = URLRequest(url: theUrl!)
        let finalRequest = do_cookies(myRequest)
        
		webView.load(finalRequest)

		webView.allowsBackForwardNavigationGestures = true

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)

		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false

		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
	}

	func openTapped() {
		let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)

		for website in websites {
			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}

		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(ac, animated: true)
	}

	func openPage(action: UIAlertAction) {
		let url = URL(string: "https://" + action.title!)!
		webView.load(URLRequest(url: url))
	}

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}

	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url

        decisionHandler(.allow)
/*
		if let host = url!.host {
			for website in websites {
				if host.range(of: website) != nil {
					decisionHandler(.allow)
					return
				}
			}
		}

		decisionHandler(.cancel)
*/
    }

	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

