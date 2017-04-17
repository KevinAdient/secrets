//
//  ViewController.swift
//  Project4
//
//  Created by Peter M. Gits.
//  Copyright © 2017 Adient. All rights reserved.
//

import UIKit
import WebKit


class ViewController: BaseViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
	var webView: WKWebView!
	var progressView: UIProgressView!
    
    var website = "biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w"

    var websites = ["biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w"]

//    var websites = ["agsm.adient.com/siteminderagent/forms/ag_primary.fcc?TYPE=33554433&amp;REALMOID=06-ee9a9733-4a38-4ee7-95c9-7fe1801058c2&amp;GUID=&amp;SMAUTHREASON=0&amp;METHOD=GET&amp;SMAGENTNAME=8yUsyDSZUFV1o873Kdzm1dYMiJFJF9ekwOP8E9bnkUGqJ5Nn4Wg6ke9iIkL8xSYH&amp;TARGET=-SM-HTTPS%3a%2f%2fbiprod%2eadient%2ecom%2fBOE%2fOpenDocument%2fopendoc%2fopenDocument%2ejsp%3fsIDType%3dCUID%26iDocID%3dATahFNnVW6FPiU5PkY6NW9w", "biprod.adient.com/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=ATahFNnVW6FPiU5PkY6NW9w", "apple.com", "hackingwithswift.com"]

    
    public func setupWebView() {
        let userContentController = WKUserContentController()
        if let cookies = HTTPCookieStorage.shared.cookies {
            let script = getJSCookiesString(cookies: cookies)
            let cookieScript = WKUserScript(source: script, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
            userContentController.addUserScript(cookieScript)
        }
        /*
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = userContentController
        
        self.webView = WKWebView(frame: UIScreen.main.bounds/*webViewContainer.bounds*/, configuration: webViewConfig)
        */
        let webViewConfig = self.webConfig
        if self.webView != nil {
            self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
            
        }

        self.webView = WKWebView(frame: CGRect.zero, configuration: webViewConfig)
        self.webView.navigationDelegate = self
    }

    var webConfig:WKWebViewConfiguration {
        get {
            
            // Create WKWebViewConfiguration instance
            let webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
            
            // Setup WKUserContentController instance for injecting user script
            let userController:WKUserContentController = WKUserContentController()
            
            //add script hide
            let scriptURLHide = Bundle.main.path(forResource: "hide", ofType: "js")
            //let content = String.stringWithContentsOfFile(scriptURL!, encoding: NSUTF8StringEncoding, error: nil)
            let scriptContentHide:String?
            do {
                scriptContentHide = try String(contentsOfFile:scriptURLHide!, encoding:String.Encoding.utf8);
            }catch _{
                scriptContentHide = nil;
            }
            let scriptHide = WKUserScript(source: scriptContentHide!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            userController.addUserScript(scriptHide)
            // Add a script message handler for receiving  "buttonClicked" event notifications posted from the JS document using window.webkit.messageHandlers.buttonClicked.postMessage script message
            
            
            //skipping this:  userController.add(self, name: "buttonClicked")
            
            // Get script that's to be injected into the document
            //skipping this:  let js:String = buttonClickEventTriggeredScriptToAddToDocument()
            
            // Specify when and where and what user script needs to be injected into the web document
            //skipping this:  let userScript:WKUserScript =  WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            
            // Add the user script to the WKUserContentController instance
            //skipping this:  userController.addUserScript(userScript)
            
            // Configure the WKWebViewConfiguration instance with the WKUserContentController
            webCfg.userContentController = userController;
            
            return webCfg;
        }
    }
    ///Generates script to create given cookies
    public func getJSCookiesString(cookies: [HTTPCookie]) -> String {
        var result = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
        for cookie in cookies {
            result += "document.cookie='\(cookie.name)=\(cookie.value); domain=\(cookie.domain); path=\(cookie.path); "
            if let date = cookie.expiresDate {
                result += "expires=\(dateFormatter.string(from: date)); "
            }
            if (cookie.isSecure) {
                result += "secure; "
            }
            result += "'; "
            print("cookie script now = [\(result)]\n")
        }
        return result
    }

    // adds the cookies that are already stored before the request happens
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
                /*
                 // Is the cookie for current domain?
                 if (!cookie.domain.hasSuffix(validDomain as String)) {
                 NSLog("Skipping \(String(describing: cookie.properties)) (because not \(validDomain))\n")
                 continue;
                 }
                 */
                // Are we secure only?
                if (cookie.isSecure && !requestIsSecure) {
                    NSLog("Skipping \(String(describing: cookie.properties)) (because \(String(describing: request.url?.absoluteString)) not secure)\n")
                    continue;
                }
                if(cookie.name == "JSESSIONID" || cookie.name == "BOE_SERIALIZED_SESSION" || cookie.name == "SMSESSION"){
                    print("got a stored session! = \(cookie.name)\n")
                    //cookie.expiresDate = nil
                }
                
                let value:String = String(format:"%@=%@", cookie.name, cookie.value)
                print(String(format:"cookie name = [%@], value = [%@]\n\n", cookie.name, cookie.value))
                array.add(value)
            }
        }
        
        let header = array.componentsJoined(by:";")
        request.setValue(header, forHTTPHeaderField:"Cookie")
        return request;
    }
    
    func do_cookiesOrig(_ originalRequest:URLRequest)->URLRequest {
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
    /*
            // Is the cookie for current domain?
            if (!cookie.domain.hasSuffix(validDomain as String)) {
                NSLog("Skipping \(String(describing: cookie.properties)) (because not \(validDomain))\n")
                continue;
            }
    */
            // Are we secure only?
            if (cookie.isSecure && !requestIsSecure) {
                NSLog("Skipping \(String(describing: cookie.properties)) (because \(String(describing: request.url?.absoluteString)) not secure)\n")
                continue;
            }
            if(cookie.name == "JSESSIONID" || cookie.name == "BOE_SERIALIZED_SESSION" || cookie.name == "SMSESSION"){
                print("got a stored session! = \(cookie.name)\n")
                //cookie.expiresDate = nil
            }
            if(cookie.value != "LOGGEDOFF"){
                let value:String = String(format:"%@=%@", cookie.name, cookie.value)
                print(String(format:"cookie name = [%@], value = [%@]\n\n", cookie.name, cookie.value))
                array.add(value)
            }else{
                print("cookie.value == LOGGEDOFF!")
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
            }
        }
    
        let header = array.componentsJoined(by:";")
        request.setValue(header, forHTTPHeaderField:"Cookie")
        return request;
    }
    func reloadWebView(){
        let theUrl = URL(string:"https://" + website)
        let myRequest:URLRequest = URLRequest(url: theUrl!)
//        let finalRequest = do_cookies(myRequest)
//        self.setupWebView();
//        self.webView.navigationDelegate = self
//        view = self.webView
//        self.webView.load(finalRequest)
        self.webView.load(myRequest)
       
    }
    //website gets swapped out when menu button is hit
    private func loadWebPage(){
        let theUrl = URL(string:"https://" + website)
        var myRequest:URLRequest = URLRequest(url: theUrl!)
        let finalRequest = do_cookies(myRequest)
        self.setupWebView();
        self.webView.navigationDelegate = self
        view = self.webView
        self.webView.load(finalRequest)
        
        webView.allowsBackForwardNavigationGestures = true
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
         self.addSlideMenuButton()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.loadWebPage()
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
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))

    }

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
        /*
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                // Don't even bother with values containing a `'`
                var cookieProperties = [HTTPCookiePropertyKey:Any]()
                //cookieProperties.
                cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
                print("cookie.name = [\(cookie.name)]\n")
                cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
                cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
                cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
                //print("cookie path was = [\(cookie.path)]\n")
                //cookieProperties[HTTPCookiePropertyKey.path] = "/"
                //print("cookie path now = [\(HTTPCookiePropertyKey.path)]\n")
                ///BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=
                cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                print("cookie.name = \(cookie.name)\n")
                if cookie.name == "SMSESSION" {
                    cookieProperties[HTTPCookiePropertyKey.expires] = //NSDate().addingTimeInterval(31536000)
                        NSDate().addingTimeInterval(86400)//24 hours
                                        
                    let newCookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any])
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    HTTPCookieStorage.shared.setCookie(newCookie!)
                    
                    print("name: \(cookie.name) value: \(cookie.value) expires: \(cookieProperties[HTTPCookiePropertyKey.expires])\n")
                }
                //cookieProperties[HTTPCookiePropertyKey.]
                
                let newCookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any])
                HTTPCookieStorage.shared.setCookie(newCookie!)
                
                if(cookie.value == "LOGGEDOFF"){
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    //
                    
                    print("name: \(cookie.name) value: \(cookie.value) expires: \(cookieProperties[HTTPCookiePropertyKey.expires])\n")
                    //
                }
            }
        }*/
        /* this is just for sanity check ....*/
	}
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        var bSmSessionFound:Bool = false
        
        if let urlResponse = navigationResponse.response as? HTTPURLResponse,
            let url = urlResponse.url,
            let allHeaderFields = urlResponse.allHeaderFields as? [String : String] {
            //var newCookies:[HTTPCookie] = [HTTPCookie()]
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
            print("cookies from webView:decidePolicyFor \(cookies)\n")
            //extending the expires date, no longer session...
            for cookie in cookies {
                var cookieProperties = [HTTPCookiePropertyKey:Any]()
                //cookieProperties.
                cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
                cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
                cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
                cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
                cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                print("cookie.name = \(cookie.name)\n")
                if cookie.name == "SMSESSION" {
                    bSmSessionFound = true
                cookieProperties[HTTPCookiePropertyKey.expires] = //NSDate().addingTimeInterval(31536000)
                    NSDate().addingTimeInterval(86400)
                
                    //cookieProperties[HTTPCookiePropertyKey.]
                    
                    let newCookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any])
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    HTTPCookieStorage.shared.setCookie(newCookie!)
    //HERE
                    print("name: \(newCookie?.name) value: \(newCookie?.value) expires: \(cookieProperties[HTTPCookiePropertyKey.expires]!)\n")
                }
            }
            
            if bSmSessionFound {
                HTTPCookieStorage.shared.setCookies(cookies , for: urlResponse.url!, mainDocumentURL: nil)
            }
            decisionHandler(.allow)
        }
    }

    func webViewOrig(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //var increment:Int = 0
        
        if let urlResponse = navigationResponse.response as? HTTPURLResponse,
            let url = urlResponse.url,
            let allHeaderFields = urlResponse.allHeaderFields as? [String : String] {
            //var newCookies:[HTTPCookie] = [HTTPCookie()]
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
            print("cookies from webView:decidePolicyFor \(cookies)\n")
//extending the expires date, no longer session...
            for cookie in cookies {
                if(cookie.value == "LOGGEDOFF"){
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    decisionHandler(.cancel)
                }
            }

            ///HTTPCookieStorage.shared.setCookies(cookies , for: urlResponse.url!, mainDocumentURL: nil)
            decisionHandler(.allow)
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
    // WKScriptMessageHandler Delegate
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        /*
        if let messageBody:NSDictionary = message.body as? NSDictionary {
            let idOfTappedButton:String = messageBody["ButtonId"] as! String
            //ptrParent.buyGrouponHit(graffitiMessage.graffiti_Id!, discountedPrice: 15.0, fullPrice: 25.0)
            buyGrouponHit(discountedPrice: 15.0, fullPrice: 25.0)
        }
 */
    }
    deinit {
        //webView!.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))

    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView){
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
   
    }
}

