//
//  LoginViewController.swift
//  SAP-container
//
//  Created by Mobility on 08/02/17.
//  Copyright © 2017 Adient. All rights reserved.
//

import UIKit
import DigitsKit
import Crashlytics

protocol LoginStatusDelegate {
    
    func loginFailure(_ err: NSError)
}
struct theCredentials {
    static var myUserDetails:UserDeviceDetails?
}

class LoginViewController: UIViewController
{
    var loginStatusDelegate:LoginStatusDelegate?
    var myUserDetails:UserDeviceDetails?
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var messageLabel: UILabel!
/*
    @IBAction func LoggedIn(_ sender: Any) {
        print("LoggedIn")
        print("End Time",Date())
        self.performSegue(withIdentifier: "viewSegue", sender: self)
    }
 */   
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    @IBAction func FingerPrintChallenge(_ sender: Any) {
        theCredentials.myUserDetails?.iFingerprintCounter = Int16(NSNumber(value:(theCredentials.myUserDetails?.iFingerprintCounter)! - 1))
        //  This two values identify the entry, together they become the
        //  primary key in the database
        let theDevice:UIDevice = UIDevice.current
        theCredentials.myUserDetails?.systemName = theDevice.systemName
        theCredentials.myUserDetails?.systemVersion = theDevice.systemVersion
        theCredentials.myUserDetails?.deviceName = theDevice.name
        theCredentials.myUserDetails?.uidid = UIDevice.current.identifierForVendor?.uuidString
        print(theCredentials.myUserDetails as Any)
        let myAttrService = "SAP-container"

        let myAttrAccount = theCredentials.myUserDetails?.uidid
        
        // DELETE keychain item (if present from previous run)
        
        let delete_query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: myAttrService,
            kSecAttrAccount: myAttrAccount!,
            kSecReturnData: false
        ]
        let delete_status = SecItemDelete(delete_query)
        if delete_status == errSecSuccess {
            print("Deleted successfully.")
        } else if delete_status == errSecItemNotFound {
            print("Nothing to delete.")
        } else {
            print("DELETE Error: \(delete_status).")
        }
        
        // INSERT keychain item
        
        let valueData = "The Top Secret Message V1".data(using: .utf8)!
        let sacObject =
            SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                            .userPresence,
                                            nil)!
        
        let insert_query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessControl: sacObject,
            kSecValueData: valueData,
            kSecUseAuthenticationUI: kSecUseAuthenticationUIAllow,
            kSecAttrService: myAttrService,
            kSecAttrAccount: myAttrAccount!
        ]
        let insert_status = SecItemAdd(insert_query as CFDictionary, nil)
        if insert_status == errSecSuccess {
            print("Inserted successfully.")
        } else {
            print("INSERT Error: \(insert_status).")
        }
        
        DispatchQueue.global().async {
            // RETRIEVE keychain item
            
            let select_query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: myAttrService,
                kSecAttrAccount: myAttrAccount,
                kSecReturnData: true,
                kSecUseOperationPrompt: "Authenticate: you are the owner of this device"
            ]
            var extractedData: CFTypeRef?
            let select_status = SecItemCopyMatching(select_query, &extractedData)
            if select_status == errSecSuccess {
                if let retrievedData = extractedData as? Data,
                    let secretMessage = String(data: retrievedData, encoding: .utf8) {
                    
                    print("Secret message: \(secretMessage)")
                    
                    // UI updates must be dispatched back to the main thread.
                    
                    DispatchQueue.main.async {
                        self.messageLabel.text = secretMessage
                    }
                    self.performSelector(onMainThread: #selector(self.checkDigits), with: nil, waitUntilDone: false)
                    return;
                    
                    
                } else {
                    print("Invalid data")
                }
            } else if select_status == errSecUserCanceled {
                print("User canceled the operation.")
            } else {
                print("SELECT Error: \(select_status).")
            }
            self.crashButtonTapped(self)
        }
    }
        
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        theCredentials.myUserDetails = self.appDelegate.myCoreDataManager.fetchUserDetails()

        if(theCredentials.myUserDetails == nil){
            print("they haven't signed in successfully yet")
            //create the entity here
            theCredentials.myUserDetails = (NSEntityDescription.insertNewObject(forEntityName: "UserDeviceDetails", into: self.appDelegate.myCoreDataManager.managedObjectContext) as! UserDeviceDetails)
        }else {
            print(theCredentials.myUserDetails as Any)
            print(theCredentials.myUserDetails?.authenticatedPhoneNumber as Any)
            print(theCredentials.myUserDetails?.userID as Any)
            print(theCredentials.myUserDetails?.iDigitsCounter as Any)
            print(theCredentials.myUserDetails?.iFingerprintCounter as Any)
        }
        
        let iFingerPrintCount:NSNumber = NSNumber(integerLiteral:Int(theCredentials.myUserDetails!.iFingerprintCounter))
        print("fingerprint count = \(iFingerPrintCount )\n")
        let iDigitsCount:NSNumber = NSNumber(integerLiteral:Int(theCredentials.myUserDetails!.iDigitsCounter))
        print("digits count = \(iDigitsCount)\n")
        
        setupSiren()
        self.checkFingerprint()
    }
    
    func checkFingerprint()->Void {
        if((theCredentials.myUserDetails?.iFingerprintCounter)! < 0){
            self.FingerPrintChallenge(self)
            theCredentials.myUserDetails?.iFingerprintCounter = (theCredentials.myUserDetails?.iFingerprintInterval)!
        }else {
            theCredentials.myUserDetails?.iFingerprintCounter = (theCredentials.myUserDetails?.iFingerprintCounter)! - 1
            self.performSelector(onMainThread: #selector(self.checkDigits), with: nil, waitUntilDone: false)
        }
    }
    
    func checkDigits()->Void {
        if((theCredentials.myUserDetails?.iDigitsCounter)! < 0){
            self.digitsService()
            theCredentials.myUserDetails?.iDigitsCounter = (theCredentials.myUserDetails?.iDigitsInterval)!
        }else {
            theCredentials.myUserDetails?.iDigitsCounter = (theCredentials.myUserDetails?.iDigitsCounter)! - 1
            if (theCredentials.myUserDetails?.hasChanges)! {
                self.appDelegate.myCoreDataManager.saveContext()
            }
            self.performSegue(withIdentifier: "viewSegue", sender: self)
        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    func digitsService() -> Void {
        let digits = Digits.sharedInstance()
        //we wouldn't be here if the iDigitsCounter weren't zero or time to be refreshed
        //we got here and need to log out if we want the prompt to show
        //if theCredentials.myUserDetails?.userID != nil {
            digits.logOut()
        //}
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        if let myPhone = theCredentials.myUserDetails?.authenticatedPhoneNumber{
            //use the last phone number I used
            configuration?.phoneNumber = myPhone
        }else {
            configuration?.phoneNumber = "+1"
        }
        let theme = DGTAppearance();
        theme.bodyFont = UIFont(name: "Noteworthy-Light", size: 16);
        theme.labelFont = UIFont(name: "Noteworthy-Bold", size: 17);
        theme.accentColor = UIColor(red: (255.0/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1);
        theme.backgroundColor = UIColor(red: (240.0/255.0), green: (255/255.0), blue: (250/255.0), alpha: 1);
        theCredentials.myUserDetails?.iDigitsCounter = Int16(NSNumber(value:(theCredentials.myUserDetails?.iDigitsCounter)! - 1))
        
        digits.authenticate(with: nil, configuration: configuration!) {session, error in
            
        if ((session?.userID) != nil){
            theCredentials.myUserDetails?.userID = session?.userID
            theCredentials.myUserDetails?.authenticatedPhoneNumber = session?.phoneNumber
            theCredentials.myUserDetails?.digitsAuthToken = session?.authToken
            theCredentials.myUserDetails?.digitsAuthToken = session?.authTokenSecret
            print("Phone Number confirmed: \(String(describing: session?.phoneNumber))\n")
            print(session!)
            if(session?.phoneNumber.lengthOfBytes(using:String.Encoding.ascii) != 0 && session?.userID.lengthOfBytes(using:String.Encoding.ascii) != 0)
            {
                print("succeeded")
                if (theCredentials.myUserDetails?.hasChanges)! {
                    self.appDelegate.myCoreDataManager.saveContext()
                }
                self.performSegue(withIdentifier: "viewSegue", sender: self)
                return
            }
            else{
                print("failed, don't proceed")
                self.crashButtonTapped(self)
            }
        }
        }
    }

    func crashButtonTapped(_ _sender:AnyObject){
        let alert = UIAlertController(title: "Failed Authentication Challenge", message: "Exiting Now!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated:true, completion:nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Crashlytics.sharedInstance().crash()
        }
    }
    func setupSiren() {
        let siren = Siren.sharedInstance
        
        // Optional
        siren.delegate = self
        
        // Optional
        siren.debugEnabled = true
        
        // Optional
        siren.appName = "SAPcontainer"
        
        // Optional - Defaults to .Option
        //        siren.alertType = .Option // or .Force, .Skip, .None
        
        // Optional - Can set differentiated Alerts for Major, Minor, Patch, and Revision Updates (Must be called AFTER siren.alertType, if you are using siren.alertType)
        siren.majorUpdateAlertType = .option
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.revisionUpdateAlertType = .option
        
        // Optional - Sets all messages to appear in Spanish. Siren supports many other languages, not just English and Russian.
        //        siren.forceLanguageLocalization = .Russian
        
        // Optional - Set this variable if your app is not available in the U.S. App Store. List of codes: https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/AppStoreTerritories.html
        //        siren.countryCode = ""
        
        // Optional - Set this variable if you would only like to show an alert if your app has been available on the store for a few days. The number 5 is used as an example.
        //        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 5
        
        // Required
        siren.checkVersion(checkType: .immediately)
    }
}

extension LoginViewController: SirenDelegate
{
    func sirenDidShowUpdateDialog(alertType: SirenAlertType) {
        print(#function, alertType)
    }
    
    func sirenUserDidCancel() {
        print(#function)
    }
    
    func sirenUserDidSkipVersion() {
        print(#function)
    }
    
    func sirenUserDidLaunchAppStore() {
        print(#function)
    }
    
    func sirenDidFailVersionCheck(error: NSError) {
        print(#function, error)
    }
    
    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }
    
    // This delegate method is only hit when alertType is initialized to .none
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
        print(#function, "\(message)")
    }
}

/*
 DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
 self.checkFingerprint()
 return
 }
 self.performSelector(onMainThread: #selector(self.checkFingerprint), with: nil, waitUntilDone: true)
 */

