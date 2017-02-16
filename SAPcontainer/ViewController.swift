//
//  ViewController.swift
//  Project4
//
//  Created by Peter M. Gits.
//  Copyright © 2017 Adient. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
	var webView: WKWebView!
	var progressView: UIProgressView!

    var websites = ["biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w"]

//    var websites = ["agsm.adient.com/siteminderagent/forms/ag_primary.fcc?TYPE=33554433&amp;REALMOID=06-ee9a9733-4a38-4ee7-95c9-7fe1801058c2&amp;GUID=&amp;SMAUTHREASON=0&amp;METHOD=GET&amp;SMAGENTNAME=8yUsyDSZUFV1o873Kdzm1dYMiJFJF9ekwOP8E9bnkUGqJ5Nn4Wg6ke9iIkL8xSYH&amp;TARGET=-SM-HTTPS%3a%2f%2fbiprod%2eadient%2ecom%2fBOE%2fOpenDocument%2fopendoc%2fopenDocument%2ejsp%3fsIDType%3dCUID%26iDocID%3dATahFNnVW6FPiU5PkY6NW9w", "biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w", "apple.com", "hackingwithswift.com"]

	override func loadView() {
		self.webView = WKWebView()
		self.webView.navigationDelegate = self
		view = self.webView
	}

    func do_cookies(_ originalRequest:URLRequest)->URLRequest {
        var request:URLRequest = originalRequest
        request.httpShouldHandleCookies = true
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
/*
    var webConfig:WKWebViewConfiguration {
        get {
            
        // Create WKWebViewConfiguration instance
        let webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
        
        // Setup WKUserContentController instance for injecting user script
        let userController:WKUserContentController = WKUserContentController()
        
        //add script cookie
            let jsCookieScript:String = String.init(describing:"var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n", encoding:String.Encoding.utf8)
        let scriptGetCookies = WKUserScript(source: jsCookieScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        userController.addUserScript(scriptGetCookies)

        webCfg.userContentController = userController;
        
        return webCfg;
        }
    }

    // Get the currently set cookie names in javascriptland
    
    
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
    // Skip cookies that will break our script
    if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
    continue;
    }
    
    // Create a line that appends this cookie to the web view's document's cookies
    [script appendFormat:@"if (cookieNames.indexOf('%@') == -1) { document.cookie='%@'; };\n", cookie.name, cookie.wn_javascriptString];
    }
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    WKUserScript *cookieInScript = [[WKUserScript alloc] initWithSource:script
    injectionTime:WKUserScriptInjectionTimeAtDocumentStart
    forMainFrameOnly:NO];
    [userContentController addUserScript:cookieInScript];

    // Create a config out of that userContentController and specify it when we create our web view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:webView.bounds configuration:config];
    Dealing with cookie changes
    
    We also need to deal with the server changing a cookie's value. This means adding another script to call back out of the web view we are creating to update our NSHTTPCookieStorage.
    
    WKUserScript *cookieOutScript = [[WKUserScript alloc] initWithSource:@"window.webkit.messageHandlers.updateCookies.postMessage(document.cookie);"
    injectionTime:WKUserScriptInjectionTimeAtDocumentStart
    forMainFrameOnly:NO];
    [userContentController addUserScript:cookieOutScript];
    
    [userContentController addScriptMessageHandler:webView
    name:@"updateCookies"];
    and implementing the delegate method to update any cookies that have changed, making sure that we are only updating cookies from the current domain!
    
    - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSArray<NSString *> *cookies = [message.body componentsSeparatedByString:@"; "];
    for (NSString *cookie in cookies) {
    // Get this cookie's name and value
    NSArray<NSString *> *comps = [cookie componentsSeparatedByString:@"="];
    if (comps.count < 2) {
    continue;
    }
    
    // Get the cookie in shared storage with that name
    NSHTTPCookie *localCookie = nil;
    for (NSHTTPCookie *c in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:self.wk_webView.URL]) {
    if ([c.name isEqualToString:comps[0]]) {
    localCookie = c;
    break;
    }
    }
*/
    override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let theUrl = URL(string:"https://" + websites[0])
        var myRequest:URLRequest = URLRequest(url: theUrl!)
        let finalRequest = do_cookies(myRequest)
        
		webView.load(finalRequest)

		webView.allowsBackForwardNavigationGestures = true
/*
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
*/
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
    
    func webViewDidClose(_ webView: WKWebView){
        print("webViewDidClose\n")
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                // Don't even bother with values containing a `'`
                print(cookie)
            }
        }
    }

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                // Don't even bother with values containing a `'`
                print(cookie)
            }
        }
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

