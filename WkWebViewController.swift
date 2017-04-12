//
//  WkWebViewController.swift
//  Browser
//
//  Created by Peter M. Gits 05/13/16.
//  Copyright (c) 2016 GeekGaps.com. All rights reserved.
//


import UIKit
import WebKit



let PostSelected = "postSelected"
let MessageHandler = "didGetPosts"

class WkWebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {
    
    var ptrParent:  UIViewController!
    var graffitiMessage: GraffitiMessageEntity!
    var couponDetails: couponDetailsUrl!
    var myGrouponUrl:NSString!
    var theWebView: WKWebView!
    var postsWebView: WKWebView?
//    var posts: [Post] = []
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var recentPostsButton: UIBarButtonItem!
    
    var colors:[String] = ["0xff00ff","#ff0000","#ffcc00","#ccff00","#ff0033","#ff0099","#cc0099","#0033ff","#0066ff","#ffff00","#0000ff","#0099cc"];
/*
    var webConfig:WKWebViewConfiguration {
        get {
            
            // Create WKWebViewConfiguration instance
            let webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
            
            // Setup WKUserContentController instance for injecting user script
            let userController:WKUserContentController = WKUserContentController()
            
            // Add a script message handler for receiving  "buttonClicked" event notifications posted from the JS document using window.webkit.messageHandlers.buttonClicked.postMessage script message
            userController.add(self, name: "buttonClicked")
            
            // Get script that's to be injected into the document
            let js:String = buttonClickEventTriggeredScriptToAddToDocument()
            
            // Specify when and where and what user script needs to be injected into the web document
            let userScript:WKUserScript =  WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            
            // Add the user script to the WKUserContentController instance
            userController.addUserScript(userScript)
            
            // Configure the WKWebViewConfiguration instance with the WKUserContentController
            webCfg.userContentController = userController;
            
            return webCfg;
        }
    }
 */
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
            userController.add(self, name: "buttonClicked")
            
            // Get script that's to be injected into the document
            let js:String = buttonClickEventTriggeredScriptToAddToDocument()
            
            // Specify when and where and what user script needs to be injected into the web document
            let userScript:WKUserScript =  WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            
            // Add the user script to the WKUserContentController instance
            userController.addUserScript(userScript)
            
            // Configure the WKWebViewConfiguration instance with the WKUserContentController
            webCfg.userContentController = userController;
            
            return webCfg;
        }
    }
    // Button Click Script to Add to Document
    func buttonClickEventTriggeredScriptToAddToDocument() ->String{
        // Script: When window is loaded, execute an anonymous function that adds a "click" event handler function to the "ClickMeButton" button element. The "click" event handler calls back into our native code via the window.webkit.messageHandlers.buttonClicked.postMessage call
        var script:String?
        
        if let filePath:String = Bundle(for: WkWebViewController.self).path(forResource: "ClickMeEventRegister", ofType:"js") {
            
            script = try? String (contentsOfFile: filePath, encoding: String.Encoding.utf8)
        }
        return script!;
        
    }
    // WKScriptMessageHandler Delegate
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let messageBody:NSDictionary = message.body as? NSDictionary {
            let idOfTappedButton:String = messageBody["ButtonId"] as! String
            //ptrParent.buyGrouponHit(graffitiMessage.graffiti_Id!, discountedPrice: 15.0, fullPrice: 25.0)
            buyGrouponHit(discountedPrice: 15.0, fullPrice: 25.0)
        }
            
        
        
    }
    
    // Update color of Button with specified Id
    func updateColorOfButtonWithId(_ buttonId:String) {
        let count:UInt32 = UInt32(colors.count)
        let index:Int = Int(arc4random_uniform(count))
        let color:String = colors [index]
        
        // Script that changes the color of tapped button
        let js2:String = String(format: "var button = document.getElementById('%@'); button.style.backgroundColor='%@';", buttonId,color)
        
        theWebView?.evaluateJavaScript(js2, completionHandler: { (AnyObject, NSError) -> Void in
            NSLog("%s", #function)
            
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //var err: NSError!
    /*
        let config = WKWebViewConfiguration()
        
        let scriptURLHide = Bundle.main.path(forResource: "hide", ofType: "js")
        //let content = String.stringWithContentsOfFile(scriptURL!, encoding: NSUTF8StringEncoding, error: nil)
        let scriptContentHide:String?
        do {
            scriptContentHide = try String(contentsOfFile:scriptURLHide!, encoding:String.Encoding.utf8);
        }catch _{
            scriptContentHide = nil;
        }
        let scriptHide = WKUserScript(source: scriptContentHide!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(scriptHide)
        
        let scriptURL = Bundle.main.path(forResource: "ClickMeEventRegister", ofType: "js")
        //let content = String.stringWithContentsOfFile(scriptURL!, encoding: NSUTF8StringEncoding, error: nil)
        let scriptContent:String?
        do {
            scriptContent = try String(contentsOfFile:scriptURL!, encoding:String.Encoding.utf8);
        }catch _{
            scriptContent = nil;
        }
        let script = WKUserScript(source: scriptContent!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        
        config.userContentController.add(self, name: MessageHandler)
*/
        self.theWebView = WKWebView(frame: CGRect.zero, configuration: webConfig)
        self.theWebView.navigationDelegate = self
    }
/*
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //var err: NSError!
        let config = WKWebViewConfiguration()
        
        let scriptURLHide = Bundle.main.path(forResource: "hide", ofType: "js")
        //let content = String.stringWithContentsOfFile(scriptURL!, encoding: NSUTF8StringEncoding, error: nil)
        let scriptContentHide:String?
        do {
            scriptContentHide = try String(contentsOfFile:scriptURLHide!, encoding:String.Encoding.utf8);
        }catch _{
            scriptContentHide = nil;
        }
        let scriptHide = WKUserScript(source: scriptContentHide!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(scriptHide)
        
        let scriptURL = Bundle.main.path(forResource: "ClickMeEventRegister", ofType: "js")
        //let content = String.stringWithContentsOfFile(scriptURL!, encoding: NSUTF8StringEncoding, error: nil)
        let scriptContent:String?
        do {
            scriptContent = try String(contentsOfFile:scriptURL!, encoding:String.Encoding.utf8);
        }catch _{
            scriptContent = nil;
        }
        let script = WKUserScript(source: scriptContent!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        
        config.userContentController.add(self, name: MessageHandler)
        self.theWebView = WKWebView(frame: CGRect.zero, configuration: config)
        self.theWebView.navigationDelegate = self
    }
*/
/*
    required init(coder aDecoder: NSCoder) {
        let config = WKWebViewConfiguration()
        let scriptURL = Bundle.main.path(forResource: "hideSections", ofType: "js")
        
        var script:String?
        
        if let filePath:String = Bundle(for: MyWebViewController.self).path(forResource: "ClickMeEventRegister", ofType:"js") {
            
            script = try? String (contentsOfFile: filePath, encoding: String.Encoding.utf8)

        }
        let scriptContent = try? String (contentsOfFile:scriptURL!, encoding:String.Encoding.utf8)
        
        let wkUserScript = WKUserScript(source: scriptContent!, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(wkUserScript)
        self.theWebView = WKWebView(frame: CGRect.zero, configuration: config)
        super.init(coder: aDecoder)!
        self.theWebView.navigationDelegate = self
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.insertSubview(theWebView, belowSubview: progressView)
        
        theWebView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: theWebView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -44)
        let width = NSLayoutConstraint(item: theWebView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        theWebView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        theWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        theWebView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        let url = URL(string: myGrouponUrl as String)
        let request = URLRequest(url:url!)
        theWebView!.load(request)

        backButton.isEnabled = false
        forwardButton.isEnabled = false
        recentPostsButton.isEnabled = false
/*
        let config = WKWebViewConfiguration()
        let scriptURL = Bundle.main.path(forResource: "getPosts", ofType: "js")
        let scriptContent:String?
        do {
            scriptContent = try String(contentsOfFile:scriptURL!, encoding:String.Encoding.utf8);
        }catch _{
            scriptContent = nil;
        }

        //let scriptContent = String(contentsOfFile:scriptURL!, encoding:String.Encoding.utf8, error: nil)
        let script = WKUserScript(source: scriptContent!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        config.userContentController.add(self, name: MessageHandler)
        postsWebView = WKWebView(frame: CGRect.zero, configuration: config)
        postsWebView!.load(URLRequest(url:URL(string:"http://www.appcoda.com")!))
*/
//        theWebView!.load(URLRequest(url:URL(string:"http://www.appcoda.com")!))
/*
        NotificationCenter.default.addObserver(self, selector: #selector(WkWebViewController.postSelected(_:)), name: NSNotification.Name(rawValue: PostSelected), object: nil)
 */
    }
    override func viewWillDisappear(_ animated: Bool) {
        theWebView!.removeObserver(self, forKeyPath: "loading")
        theWebView!.removeObserver(self, forKeyPath: "estimatedProgress")
        theWebView!.removeObserver(self, forKeyPath: "title")
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        theWebView.goBack()
    }
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        theWebView.goForward()
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        let request = URLRequest(url:theWebView.url!)
        theWebView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "loading") {
            backButton.isEnabled = theWebView.canGoBack
            forwardButton.isEnabled = theWebView.canGoForward
        }
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = theWebView.estimatedProgress == 1
            progressView.setProgress(Float(theWebView.estimatedProgress), animated: true)
        }
        if (keyPath == "title") {
            title = theWebView.title
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        print("Error: url = ", webView.url as Any);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        /*
        if (navigationAction.navigationType == WKNavigationType.linkActivated && !(navigationAction.request.url?.host!.lowercased().hasPrefix("www.appcoda.com"))!) {
            UIApplication.shared.openURL(navigationAction.request.url!)
            decisionHandler(WKNavigationActionPolicy.cancel)
        } else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
        */
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    @IBAction func Done(_ sender: Any) {
 //       ptrParent.dismissUsExtended(theWebView)
    }
    func webViewDidClose(_ webView: WKWebView){
        print("webViewDidClose\n")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "recentPosts") {
            let navigationController = segue.destination as! UINavigationController
        /*
            let postsViewController = navigationController.topViewController as! PostsTableViewController
            postsViewController.posts = posts
        */
        }
    }
/*
    - (void)buyGrouponHitTry:(NSString*)graffiti_Id discountedPrice:(double)dPrice fullPrice:(double)fPrice {
    NSString *postString = [[NSMutableString alloc] init];
    postString = [postString stringByAppendingString:[NSString stringWithFormat:@"graffiti_Id=%@&author_Id=%d", graffiti_Id, [self.theUserId intValue]]];
    NSString *strBuyUrl = [NSString stringWithFormat:@"%@/iBuy.php?%@", appURL4base, postString];
    NSURL *url = [NSURL URLWithString:strBuyUrl];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // Configure Session Configuration
    [config setAllowsCellularAccess:YES];
    config.HTTPShouldSetCookies = NO;
    //
     config.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
     NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
     NSArray *cookies = [storage cookies];
     config.HTTPAdditionalHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
     //
    // 1
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    //[request setValue:@"application/text" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    //MyLog(@"postString = %@\n", postString);
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3//
    //
     NSDictionary *dictionary = @{@"int_AppID": @"3", @"str_LoginName": @"SMLoginTest", @"str_Password": @"SM1234", @"str_UserHostName":@"", @"str_UserHostAddress":@"", @"int_LanguageID":@"0"};
     NSError *error = nil;
     NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
     options:kNilOptions error:&error];
     //
    //
     NSDictionary *dictionary = @{@"graffiti_Id":graffiti_Id, @"author_Id": [self.theUserId stringValue]};
     NSError *error = nil;
     NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
     options:kNilOptions error:&error];
     //
    //NSData *data = nil;
    NSError *error = nil;
    if (!error) {
    // 4
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *rdata,NSURLResponse *response,NSError *error)
    {
    // Handle response here
    //NSLog(@"response code = %@\n", [[response getStatusCode]);// statusCode])
    if(error != NULL){
    NSLog(@"error = %@\n", error);
    }
    }];
    // 5
    [dataTask resume];
    }
    }
*/
    func buyGrouponHit(discountedPrice dPrice:Double, fullPrice fPrice:Double)
    {
        let strBuyUrl = String(format: "%@/iBuy.php", (mySingleton.getUserDetails().appURL4base)!)
        let paramString = String(format:"graffiti_Id=%@&author_Id=%d", graffitiMessage.graffiti_Id!, mySingleton.getUserDetails().theUserId);

        let url:NSURL = NSURL(string: strBuyUrl)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData//ReloadIgnoringCacheData
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                session.invalidateAndCancel()
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString as Any)
            session.invalidateAndCancel()
        }
        task.resume()
    }
/*
    func postSelected(_ notification:Notification) {
        theWebView.load(URLRequest())
        let post = notification.object as! Post
        theWebView.load(URLRequest(url:URL(string:post.postURL)!))
    }
 */
}

/* missing Post dictionary
 func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
 if (message.name == MessageHandler) {
 if let postsList = message.body as? [Dictionary<String, String>] {
 for ps in postsList {
 let post = Post(dictionary: ps)
 posts.append(post)
 }
 recentPostsButton.isEnabled = true
 }
 }
 }
 */
