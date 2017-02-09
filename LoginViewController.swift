//
//  LoginViewController.swift
//  SAP-container
//
//  Created by Mobility on 08/02/17.
//  Copyright © 2017 Adient. All rights reserved.
//

import UIKit
import DigitsKit

protocol LoginStatusDelegate {
    
    func loginFailure(_ err: NSError)
    //    func triggerSSO(sessionKey : String)
}
//let LoginSuccessVCSegue = "LoginSuccess"
//let LoginSuccessDirectHomeVCSegue = "GoToHomeFromLogin"
//let PASSWORD_REGEX = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{8,20})"

class LoginViewController: UIViewController
{
    var loginStatusDelegate:LoginStatusDelegate?
    
    
    
    @IBAction func LoggedIn(_ sender: Any) {
        print("LoggedIn")
    }
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.fabricService()
        /*
        let authButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: NSError?) in
            if (session != nil) {
                // TODO: associate the session userID with your user model
                let message = "Phone number: \(session!.phoneNumber)"
                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: .none))
                self.present(alertController, animated: true, completion: .none)
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
            } as! DGTAuthenticationCompletion)
        authButton?.center = self.view.center
        self.view.addSubview(authButton!)
 */
 }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    
    func sessionSucess()
    {
            UIApplication.shared.endIgnoringInteractionEvents()
            print("End Time",Date())
            self.performSegue(withIdentifier: "SitesTableSegue", sender: self)
    }
    
    func fabricService() -> Void {
        
        let digits = Digits.sharedInstance()
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.phoneNumber = "+1" /*+ textFieldPhone.text!*/
        let theme = DGTAppearance();
        theme.bodyFont = UIFont(name: "Noteworthy-Light", size: 16);
        theme.labelFont = UIFont(name: "Noteworthy-Bold", size: 17);
        theme.accentColor = UIColor(red: (255.0/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1);
        theme.backgroundColor = UIColor(red: (240.0/255.0), green: (255/255.0), blue: (250/255.0), alpha: 1);
        digits.logOut()
        digits.authenticate(with: nil, configuration: configuration!) {session, error in
            
            if ((session?.userID) != nil){
                print(session)
                //self.getPhone=(session?.phoneNumber)!
                //self.getValues()
                //DispatchQueue.main.async {
                //    self.registerServiceCalling()
                //    self.buttonShowPassword .setBackgroundImage(UIImage(named: "eyeCross"), for: .normal)
                //}
                print("succeeded")
            }
            else{
                print("failed")
                ///self.alertMessage(POST_USER_AUTHENTICATION_ERROR)
            }
        }
    }
}
    // MARK: - Storyboard Segue
    

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

/*
struct RegExp {
    
    /// **
    Check password complexity
    
    - parameter password:         password to test
    - parameter length:           password min length
    - parameter patternsToEscape: patterns that password must not contains
    - parameter caseSensitivty:   specify if password must conforms case sensitivity or not
    - parameter numericDigits:    specify if password must conforms contains numeric digits or not
    
    - returns: boolean that describes if password is valid or not
    ///
    
    static func matchesForRegexInText(_ regex: String, text: String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@",regex)
        let result = passwordTest.evaluate(with: text)
        return result
    }
}


    - (void)viewDidLoad {
        [super viewDidLoad];
        myUserAndDeviceDetails = [UserAndDeviceDetails sharedManager];
        self.bLoggedOut = FALSE;
        bFirstTimeRegisterLocationForDump = TRUE;
        
        
        //TODO as more functionality is added, change 'comingsoon' attribute to NO.
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL credentialPrompt = [defaults boolForKey:@"CredentialPrompt"];
        DigitsSignInButton.hidden = YES;
        logOutOfDigitsButton.hidden = YES;
        self.TouchIDButton.hidden = YES;
        
        
        MyLog(@"credentialPrompt = %i",credentialPrompt);
        if(credentialPrompt == YES){
            credentialPrompt = NO;
            [defaults setObject:[NSNumber numberWithBool:credentialPrompt] forKey:@"CredentialPrompt"];
            [[Digits sharedInstance] logOut];
            self.bLoggedOut = TRUE;
        }
        NSNumber* touchIDPrompt = [defaults objectForKey:@"TouchIDPrompt"];
        NSString* phoneNumber   = [defaults objectForKey:@"phoneNumber"];
        NSString* userID        = [defaults objectForKey:@"userID"];
        MyLog(@"phoneNumber = %@ and userID = %@\n", phoneNumber, userID);
        
        NSNumber* iFingerPrintCounter = [defaults objectForKey:@"TouchIDCounter"];
        iFingerPrintCounter = [NSNumber numberWithInt:[iFingerPrintCounter intValue] + 1];
        if([iFingerPrintCounter intValue] >= [touchIDPrompt intValue]){
            iFingerPrintCounter = [NSNumber numberWithInt:0];
            bPromptForFingerPrint = TRUE;
        }
        MyLog(@"iFingerPrintCounter = %@\n", iFingerPrintCounter);
        [defaults setObject:iFingerPrintCounter forKey:@"TouchIDCounter"];
        myUserAndDeviceDetails.iFingerprintCounter = iFingerPrintCounter;
        
        
        if(self.bLoggedOut == FALSE && [phoneNumber length] != 0 && [userID length] != 0){
            myUserAndDeviceDetails.authenticatedPhoneNumber = phoneNumber;
            myUserAndDeviceDetails.userID = userID;
            [CrashlyticsKit setUserIdentifier:userID];
            //we will get the actual email and name from  the OAuth2 query
            [CrashlyticsKit setUserEmail:@"peter.gits@abbvie.com"];
            [CrashlyticsKit setUserName:@"Peter M. Gits"];
            [CrashlyticsKit setObjectValue:myUserAndDeviceDetails.uidid forKey:@"deviceId"];
            
            if(bPromptForFingerPrint == TRUE)
            [self authenticateButtonTapped: self];
            else
            [self TappedDigitsButton:self];
            [defaults synchronize];
        }else if([phoneNumber length] == 0 && [userID length] == 0)
        self.bLoggedOut = TRUE;
        
        [self setTableDataWithPlist];
        if(self.bLoggedOut == TRUE){
            bPromptForFingerPrint = TRUE;
            iFingerPrintCounter = [NSNumber numberWithInt:0];
            MyLog(@"iFingerPrintCounter reset = %@\n", iFingerPrintCounter);
            [defaults setObject:iFingerPrintCounter forKey:@"TouchIDCounter"];
            myUserAndDeviceDetails.iFingerprintCounter = iFingerPrintCounter;
            [defaults synchronize];
            [self authenticateButtonTapped: self];
            return;
        }else
        [self startListeningGps];
        /*
         if([ptrNotifications getSize] > 0){
         NSString *badgeStr = [NSString stringWithFormat:@"%@", [ptrNotifications getSize]];
         [[notificationsButton setBadgeValue:badgeStr];
         }*/
}

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (UIImage*) includeNumber:(NSString*) text
inImage:(UIImage*)  image
atPoint:(CGPoint)   point
{
    
    //UIFont* font = [UIFont systemFontOfSize:16.0];
    
    UIFont *font = [UIFont systemFontOfSize:50];
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    //NSDictionary *attributes = @{ NSFontAttributeName: font,                                      NSParagraphStyleAttributeName: paragraphStyle };
    NSDictionary *attributes = @{
        NSFontAttributeName:font,
        NSParagraphStyleAttributeName:paragraphStyle,
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    CGRect rect  =  CGRectMake(0, 0, image.size.width, image.size.height);
    int midY =  (CGRectGetMidY(rect) - (font.lineHeight/2));
    
    int midYadj = midY - (midY/3);
    
    CGRect rect2 = CGRectMake(0, midYadj, image.size.width, image.size.height);
    
    
    //[UIColorFromRGB(0xFFFFFF) set];
    [text drawInRect:CGRectIntegral(rect2) withAttributes:attributes];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    }
    
    - (IBAction)crashButtonTapped:(id)sender {
        [[Crashlytics sharedInstance] crash];
        }
        
        //if prompt for fingerPrint, first time and then after restart counter...
        - (IBAction)TappedDigitsButton:(id)sender {
            [[Digits sharedInstance] authenticateWithCompletion:^(DGTSession *session, NSError *error) {
                MyLog(@"session.phoneNumber = %@ and session.userID = %@\n", session.phoneNumber, session.userID);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:session.phoneNumber forKey:@"phoneNumber"];
                [defaults setObject:session.userID      forKey:@"userID"];
                if([session.phoneNumber length] != 0 && [session.userID length] != 0){
                DigitsSignInButton.hidden = YES;
                myUserAndDeviceDetails.authenticatedPhoneNumber = session.phoneNumber;
                myUserAndDeviceDetails.userID = session.userID;
                self.bLoggedOut = FALSE;
                [self startListeningGps];
                }
                [defaults synchronize];
                // Inspect session/error objects
                }];
            }
            
            - (IBAction)logOutOfDigits:(id)sender {
                [[Digits sharedInstance] logOut];
                self.bLoggedOut = TRUE;
                logOutOfDigitsButton.hidden = YES;
                DigitsSignInButton.hidden = NO;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:nil forKey:@"phoneNumber"];
                [defaults setObject:nil forKey:@"userID"];
                myUserAndDeviceDetails.authenticatedPhoneNumber = nil;
                myUserAndDeviceDetails.userID = nil;
                [defaults synchronize];
                }
                
                - (IBAction)authenticateButtonTapped:(id)sender {
                    CFErrorRef error = NULL;
                    
                    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                                    kSecAccessControlUserPresence,
                                                                                    &error);
                    if (sacObject == NULL || error != NULL) {
                        NSString *errorString = [NSString stringWithFormat:@"SecItemAdd can't create sacObject: %@", error];
                        NSLog(@"Error = %@", errorString);
                        return;
                    }
                    NSDictionary *attributes = @{
                        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                        (__bridge id)kSecAttrService: @"AbbvieService",
                        (__bridge id)kSecReturnData: @YES,
                        (__bridge id)kSecUseOperationPrompt: @"Device Owner Challenge",
                        (__bridge id)kSecAttrAccessControl: (__bridge_transfer id)sacObject
                        ,
                    };
                    
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        CFTypeRef dataTypeRef = NULL;
                        //the important idea here is that you need to have something added to the keystore and then
                        //query it to get the touchID challenge.  If it isn't there and you query it, it doesn't prompt
                        
                        //the actual thing you are storing is orthogonal
                        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
                        NSString *errorString = [self keychainErrorToString:status];
                        NSString *message = [NSString stringWithFormat:@"SecItemAdd status: %@", errorString];
                        MyLog(@"messsage = %@\n", message);
                        
                        dataTypeRef = NULL;
                        //regardless if it is already there we now query it to force the prompt
                        
                        message = [NSString stringWithFormat:@"SecItemCopyMatching status: %@", [self keychainErrorToString:status]];
                        OSStatus status2 = SecItemCopyMatching((__bridge CFDictionaryRef)(attributes), &dataTypeRef);
                        if (status2 == errSecSuccess) {
                            NSData *resultData = (__bridge_transfer NSData *)dataTypeRef;
                            
                            NSString *result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
                            
                            message = [NSString stringWithFormat:@"Result: %@\n", result];
                            MyLog(@"successfully passed the device credential challenge\n");
                            self.TouchIDButton.hidden = YES;
                            bPromptForFingerPrint = FALSE;//going to do it below
                            if(self.bLoggedOut == TRUE){
                                [self TappedDigitsButton:self];
                            }
                            return;
                        }
                        else {
                            message = [NSString stringWithFormat:@"SecItemCopyMatching status: %@", [self keychainErrorToString:status]];
                        }
                        NSLog(@"message equals = %@\n", message);
                        [self performSelectorOnMainThread:@selector(ShowErrorAlert:) withObject:@"Authentication was cancelled by the user" waitUntilDone:NO];
                        });
                    }
                    
                    - (NSString *)keychainErrorToString:(OSStatus)error {
                        NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
                        
                        switch (error) {
                        case errSecSuccess:
                            message = @"success";
                            break;
                            
                        case errSecDuplicateItem:
                            message = @"error item already exists";
                            break;
                            
                        case errSecItemNotFound :
                            message = @"error item not found";
                            break;
                            
                        case errSecAuthFailed:
                            message = @"error item authentication failed";
                            break;
                            
                        default:
                            break;
                        }
                        
                        return message;
}


-(void) showPasswordAlert:(NSString*)myPopupMessage {
    UIAlertController *alertController = [UIAlertController                                          alertControllerWithTitle:@"Enter Passcode"
        message:@"passcode"
        preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
        {
        textField.placeholder = NSLocalizedString(@"PasswordPlaceholder", @"Password");
        textField.secureTextEntry = YES;
        }];
    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action)
        {
        
        //UITextField *password = alertController.textFields.lastObject;
        //NSLog(@"password now = %@", password);
        }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) SkipSuccessAlert:(NSString*)myPopupMessage {
    self.TouchIDButton.hidden = YES;
    bPromptForFingerPrint = FALSE;//going to do it below
    if(self.bLoggedOut == TRUE){
        [self TappedDigitsButton:self];
    }
}

-(void) ShowSuccessAlert:(NSString*)myPopupMessage {
    self.TouchIDButton.hidden = YES;
    UIAlertController *alertController = [UIAlertController
        alertControllerWithTitle:@"Success"
        message:myPopupMessage
        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *action)
        {
        MyLog(@"OK action");
        }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    [self TappedDigitsButton:self];
    bPromptForFingerPrint = FALSE;//going to do it below
    
    //added here to force it
}

 

    //
    //  MainViewController.m
    //  AbbVie Supply Chain
    //
    //  Created by Janet Lin on 7/15/15.
    //  Copyright (c) 2015 AbbVie Inc. All rights reserved.
    //
    #import <UIKit/UIKit.h>
    
    #import "MainViewController.h"
    #import "MenuButton.h"
    #import "ProductAuthMainViewController.h"
    #import "MSCellAccessory.h"
    #import "CustomerServiceViewController.h"
    #import "FileHelper.h"
    #import "BarcodeReaderViewController.h"
    #import <QuartzCore/QuartzCore.h>
    #import <Fabric/Fabric.h>
    #import <DigitsKit/DigitsKit.h>
    #import <Crashlytics/Crashlytics.h>
    #import <LocalAuthentication/LocalAuthentication.h>
    #import "UserAndDeviceDetails.h"
    #import "UserScanHistoryViewController.h"
    #import "DVViewController.h"
    #import "CSRViewController.h"
    #import "PackageHierarchyViewController.h"
    #import <Security/Security.h>
    #import "MapViewControllerParent.h"
    #import "AssestManagementVerifyViewController.h"
    
    
    
    @interface MainViewController ()
    {
    
    }
    @property (weak, nonatomic) IBOutlet UITableView *favTableView;
    
    @end
    
    @implementation MainViewController
    
    @synthesize customerServiceButton,takePhotoButton,notificationsButton,favTableView, DigitsSignInButton, bPromptForFingerPrint, TouchIDButton, logOutOfDigitsButton;
    @synthesize lastKnownLocation, locationManager, myUserAndDeviceDetails;
    @synthesize bFirstTimeRegisterLocationForDump;
    @synthesize delegate;
    
    NSMutableArray *_tableData;
    static NSString *_tableIdentifier = @"mainViewControllerTableID";
    
    #ifdef ABBVIE_DEBUG
    #define MyLog NSLog
    #else
    #define MyLog(...)
    #endif
    
    - (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self setNavigationUI];
    /* */
    [customerServiceButton setTitle:NSLocalizedString(@"CUSTOMER_SERVICE", nil) forState:UIControlStateNormal];
    [takePhotoButton setTitle:NSLocalizedString(@"TAKE_PHOTO", nil) forState:UIControlStateNormal];
    [notificationsButton setTitle:NSLocalizedString(@"NOTIFICATIONS", nil) forState:UIControlStateNormal];
    
    if (delegate) {
    [delegate moveSettingPanelToOrginalPosition];
    [delegate movePanelToOriginalPosition];
    }
    
    [self setTableDataWithPlist];
    [favTableView  reloadData];
    NotificationViewController* ptrNotifications = [self.delegate getNotificationViewController];
    NSNumber *orderNumber = [ptrNotifications getSize];
    if([orderNumber intValue] > 0){
    self.NotificationCountImage.hidden = FALSE;
    //NSNumber *orderNumber = [[NSNumber alloc] initWithInt:125];
    UIImage* bubbleIconImage;
    bubbleIconImage = [UIImage imageNamed:@"notificationRedCircle.png"];
    CGPoint startOffset;
    startOffset.x = bubbleIconImage.size.width/2;
    startOffset.y = bubbleIconImage.size.height/4;
    self.NotificationCountImage.image = [self includeNumber:orderNumber.stringValue inImage:bubbleIconImage atPoint:startOffset];
    }else
    self.NotificationCountImage.hidden = TRUE;
    }
    
    - (void)viewDidLoad {
    [super viewDidLoad];
    myUserAndDeviceDetails = [UserAndDeviceDetails sharedManager];
    self.bLoggedOut = FALSE;
    bFirstTimeRegisterLocationForDump = TRUE;
    
    
    //TODO as more functionality is added, change 'comingsoon' attribute to NO.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL credentialPrompt = [defaults boolForKey:@"CredentialPrompt"];
    DigitsSignInButton.hidden = YES;
    logOutOfDigitsButton.hidden = YES;
    self.TouchIDButton.hidden = YES;
    
    
    MyLog(@"credentialPrompt = %i",credentialPrompt);
    if(credentialPrompt == YES){
    credentialPrompt = NO;
    [defaults setObject:[NSNumber numberWithBool:credentialPrompt] forKey:@"CredentialPrompt"];
    [[Digits sharedInstance] logOut];
    self.bLoggedOut = TRUE;
    }
    NSNumber* touchIDPrompt = [defaults objectForKey:@"TouchIDPrompt"];
    NSString* phoneNumber   = [defaults objectForKey:@"phoneNumber"];
    NSString* userID        = [defaults objectForKey:@"userID"];
    MyLog(@"phoneNumber = %@ and userID = %@\n", phoneNumber, userID);
    
    NSNumber* iFingerPrintCounter = [defaults objectForKey:@"TouchIDCounter"];
    iFingerPrintCounter = [NSNumber numberWithInt:[iFingerPrintCounter intValue] + 1];
    if([iFingerPrintCounter intValue] >= [touchIDPrompt intValue]){
    iFingerPrintCounter = [NSNumber numberWithInt:0];
    bPromptForFingerPrint = TRUE;
    }
    MyLog(@"iFingerPrintCounter = %@\n", iFingerPrintCounter);
    [defaults setObject:iFingerPrintCounter forKey:@"TouchIDCounter"];
    myUserAndDeviceDetails.iFingerprintCounter = iFingerPrintCounter;
    
    
    if(self.bLoggedOut == FALSE && [phoneNumber length] != 0 && [userID length] != 0){
    myUserAndDeviceDetails.authenticatedPhoneNumber = phoneNumber;
    myUserAndDeviceDetails.userID = userID;
    [CrashlyticsKit setUserIdentifier:userID];
    //we will get the actual email and name from  the OAuth2 query
    [CrashlyticsKit setUserEmail:@"peter.gits@abbvie.com"];
    [CrashlyticsKit setUserName:@"Peter M. Gits"];
    [CrashlyticsKit setObjectValue:myUserAndDeviceDetails.uidid forKey:@"deviceId"];
    
    if(bPromptForFingerPrint == TRUE)
    [self authenticateButtonTapped: self];
    else
    [self TappedDigitsButton:self];
    [defaults synchronize];
    }else if([phoneNumber length] == 0 && [userID length] == 0)
    self.bLoggedOut = TRUE;
    
    [self setTableDataWithPlist];
    if(self.bLoggedOut == TRUE){
    bPromptForFingerPrint = TRUE;
    iFingerPrintCounter = [NSNumber numberWithInt:0];
    MyLog(@"iFingerPrintCounter reset = %@\n", iFingerPrintCounter);
    [defaults setObject:iFingerPrintCounter forKey:@"TouchIDCounter"];
    myUserAndDeviceDetails.iFingerprintCounter = iFingerPrintCounter;
    [defaults synchronize];
    [self authenticateButtonTapped: self];
    return;
    }else
    [self startListeningGps];
    /*
     if([ptrNotifications getSize] > 0){
     NSString *badgeStr = [NSString stringWithFormat:@"%@", [ptrNotifications getSize]];
     [[notificationsButton setBadgeValue:badgeStr];
     }*/
    }
    
    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
    
    - (UIImage*) includeNumber:(NSString*) text
    inImage:(UIImage*)  image
    atPoint:(CGPoint)   point
    {
    
    //UIFont* font = [UIFont systemFontOfSize:16.0];
    
    UIFont *font = [UIFont systemFontOfSize:50];
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    //NSDictionary *attributes = @{ NSFontAttributeName: font,                                      NSParagraphStyleAttributeName: paragraphStyle };
    NSDictionary *attributes = @{
    NSFontAttributeName:font,
    NSParagraphStyleAttributeName:paragraphStyle,
    NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    CGRect rect  =  CGRectMake(0, 0, image.size.width, image.size.height);
    int midY =  (CGRectGetMidY(rect) - (font.lineHeight/2));
    
    int midYadj = midY - (midY/3);
    
    CGRect rect2 = CGRectMake(0, midYadj, image.size.width, image.size.height);
    
    
    //[UIColorFromRGB(0xFFFFFF) set];
    [text drawInRect:CGRectIntegral(rect2) withAttributes:attributes];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    }
    
    - (IBAction)crashButtonTapped:(id)sender {
    [[Crashlytics sharedInstance] crash];
    }
    
    //if prompt for fingerPrint, first time and then after restart counter...
    - (IBAction)TappedDigitsButton:(id)sender {
    [[Digits sharedInstance] authenticateWithCompletion:^(DGTSession *session, NSError *error) {
    MyLog(@"session.phoneNumber = %@ and session.userID = %@\n", session.phoneNumber, session.userID);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:session.phoneNumber forKey:@"phoneNumber"];
    [defaults setObject:session.userID      forKey:@"userID"];
    if([session.phoneNumber length] != 0 && [session.userID length] != 0){
    DigitsSignInButton.hidden = YES;
    myUserAndDeviceDetails.authenticatedPhoneNumber = session.phoneNumber;
    myUserAndDeviceDetails.userID = session.userID;
    self.bLoggedOut = FALSE;
    [self startListeningGps];
    }
    [defaults synchronize];
    // Inspect session/error objects
    }];
    }
    
    - (IBAction)logOutOfDigits:(id)sender {
    [[Digits sharedInstance] logOut];
    self.bLoggedOut = TRUE;
    logOutOfDigitsButton.hidden = YES;
    DigitsSignInButton.hidden = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"phoneNumber"];
    [defaults setObject:nil forKey:@"userID"];
    myUserAndDeviceDetails.authenticatedPhoneNumber = nil;
    myUserAndDeviceDetails.userID = nil;
    [defaults synchronize];
    }
    
    - (IBAction)authenticateButtonTapped:(id)sender {
    CFErrorRef error = NULL;
    
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
    kSecAccessControlUserPresence,
    &error);
    if (sacObject == NULL || error != NULL) {
    NSString *errorString = [NSString stringWithFormat:@"SecItemAdd can't create sacObject: %@", error];
    NSLog(@"Error = %@", errorString);
    return;
    }
    NSDictionary *attributes = @{
    (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
    (__bridge id)kSecAttrService: @"AbbvieService",
    (__bridge id)kSecReturnData: @YES,
    (__bridge id)kSecUseOperationPrompt: @"Device Owner Challenge",
    (__bridge id)kSecAttrAccessControl: (__bridge_transfer id)sacObject
    ,
    };
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    CFTypeRef dataTypeRef = NULL;
    //the important idea here is that you need to have something added to the keystore and then
    //query it to get the touchID challenge.  If it isn't there and you query it, it doesn't prompt
    
    //the actual thing you are storing is orthogonal
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
    NSString *errorString = [self keychainErrorToString:status];
    NSString *message = [NSString stringWithFormat:@"SecItemAdd status: %@", errorString];
    MyLog(@"messsage = %@\n", message);
    
    dataTypeRef = NULL;
    //regardless if it is already there we now query it to force the prompt
    
    message = [NSString stringWithFormat:@"SecItemCopyMatching status: %@", [self keychainErrorToString:status]];
    OSStatus status2 = SecItemCopyMatching((__bridge CFDictionaryRef)(attributes), &dataTypeRef);
    if (status2 == errSecSuccess) {
    NSData *resultData = (__bridge_transfer NSData *)dataTypeRef;
    
    NSString *result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    message = [NSString stringWithFormat:@"Result: %@\n", result];
    MyLog(@"successfully passed the device credential challenge\n");
    self.TouchIDButton.hidden = YES;
    bPromptForFingerPrint = FALSE;//going to do it below
    if(self.bLoggedOut == TRUE){
    [self TappedDigitsButton:self];
    }
    return;
    }
    else {
    message = [NSString stringWithFormat:@"SecItemCopyMatching status: %@", [self keychainErrorToString:status]];
    }
    NSLog(@"message equals = %@\n", message);
    [self performSelectorOnMainThread:@selector(ShowErrorAlert:) withObject:@"Authentication was cancelled by the user" waitUntilDone:NO];
    });
    }
    
    - (NSString *)keychainErrorToString:(OSStatus)error {
    NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
    
    switch (error) {
    case errSecSuccess:
    message = @"success";
    break;
    
    case errSecDuplicateItem:
    message = @"error item already exists";
    break;
    
    case errSecItemNotFound :
    message = @"error item not found";
    break;
    
    case errSecAuthFailed:
    message = @"error item authentication failed";
    break;
    
    default:
    break;
    }
    
    return message;
    }
    
    
    -(void) showPasswordAlert:(NSString*)myPopupMessage {
    UIAlertController *alertController = [UIAlertController                                          alertControllerWithTitle:@"Enter Passcode"
    message:@"passcode"
    preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
    {
    textField.placeholder = NSLocalizedString(@"PasswordPlaceholder", @"Password");
    textField.secureTextEntry = YES;
    }];
    UIAlertAction *okAction = [UIAlertAction
    actionWithTitle:NSLocalizedString(@"OK", @"OK action")
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action)
    {
    
    //UITextField *password = alertController.textFields.lastObject;
    //NSLog(@"password now = %@", password);
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    }
    
    -(void) SkipSuccessAlert:(NSString*)myPopupMessage {
    self.TouchIDButton.hidden = YES;
    bPromptForFingerPrint = FALSE;//going to do it below
    if(self.bLoggedOut == TRUE){
    [self TappedDigitsButton:self];
    }
    }
    
    -(void) ShowSuccessAlert:(NSString*)myPopupMessage {
    self.TouchIDButton.hidden = YES;
    UIAlertController *alertController = [UIAlertController
    alertControllerWithTitle:@"Success"
    message:myPopupMessage
    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
    actionWithTitle:NSLocalizedString(@"OK", @"OK action")
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action)
    {
    MyLog(@"OK action");
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    [self TappedDigitsButton:self];
    bPromptForFingerPrint = FALSE;//going to do it below
    
    //added here to force it
    }
    
    -(void) ShowErrorAlert:(NSString*)myPopupMessage {
    self.TouchIDButton.hidden = YES;
    UIAlertController *alertController = [UIAlertController
    alertControllerWithTitle:@"Failure"
    message:myPopupMessage
    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
    actionWithTitle:NSLocalizedString(@"Exit Supply Chain", @"OK action")
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action)
    {
    NSLog(@"Exiting the app");
    assert(0);
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    //added here to force it
    }
    
    -(void) addGradiantToView: (UIView *) view
    {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    gradient.colors = [NSArray arrayWithObjects: (id)[[UIColor colorWithRed:0.094 green:0.172 blue:0.333 alpha:1] CGColor],(id)[[UIColor colorWithRed:0.023 green:0.541 blue:0.745 alpha:1] CGColor],nil];
    gradient.frame = view.bounds;
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    gradient.colors = [NSArray arrayWithObjects: (id)[[UIColor colorWithRed:0.094 green:0.172 blue:0.333 alpha:1] CGColor],(id)[[UIColor colorWithRed:0.023 green:0.541 blue:0.745 alpha:1] CGColor],nil];
    
    gradient.cornerRadius = view.layer.cornerRadius;
    
    
    
    [view.layer insertSublayer:gradient atIndex:0];
    view.layer.masksToBounds = YES;
    
    
    
    
    
    }
    
    -(void) setTableDataWithPlist
    {
    _tableData = [[NSMutableArray alloc]init];
    
    
    NSArray * tempArray = [NSArray arrayWithContentsOfFile:[FileHelper readPlishFile:@"favMenuPlist-4"]];
    
    for(NSDictionary* tempDictionary in tempArray)
    {
    if ([tempDictionary[@"isActive"] boolValue]) {
    MyLog(@"menu items %@", tempDictionary);
    [_tableData addObject:tempDictionary];
    }
    }
    }
    
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
    return [_tableData count];
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_tableIdentifier];
    
    if ([cell.contentView subviews]){
    for (UIView *subview in [cell.contentView subviews]) {
    [subview removeFromSuperview];
    }
    }
    
    cell.accessoryView =nil;
    
    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_tableIdentifier];
    }
    
    
    
    //determines needed font size of navigational items
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    }else{
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    }
    
    //cell.textLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.341 green:0.341 blue:0.341 alpha:1] /*#4a4a4a*/;
    
    
    
    
    //assigns product title/subtitles text
    NSDictionary* product = _tableData[indexPath.row];
    cell.textLabel.text = product[@"navItemName"];
    cell.detailTextLabel.text = product[@"shortDescription"];
    
    
    if (product[@"imageName"]) {
    
    UIImage * oldImage = [UIImage imageNamed:product[@"imageName"]];
    
    UIImage *image = [FileHelper resizeImageWithImage:oldImage scaledToSize:CGSizeMake(oldImage.size.width/2, oldImage.size.width/2)] ;
    
    cell.imageView.image = image;
    
    }
    
    
    
    //Adds "coming soon" banner to funtionality that is coming soon
    //TODO remove this part and images/image assets once all functionality on menu has been implemented
    if([product[@"commingSoon"] boolValue]){
    UIImage* banner = [UIImage imageNamed:@"coming_soon_label"];
    UIImageView* bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-banner.size.width/2,0,banner.size.width/2,banner.size.height/2)];
    bannerView.image = banner;
    [cell.contentView addSubview:bannerView];
    }else if([product[@"isActive"] boolValue]){
    
    UIImage *accessoryImage = [UIImage imageNamed:@"carousel"];
    
    UIImageView *accessoryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, accessoryImage.size.width/5, accessoryImage.size.height/5)];
    
    accessoryImageView.image = accessoryImage;
    
    // Sets and formats the '>' for each element only on working functionality
    cell.accessoryView =  accessoryImageView;  //[MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:
    //[UIColor colorWithRed:0.18 green:0.71 blue:0.878 alpha:1] ];/*#2eb5e0*/
    }
    
    //creates custom separator
    UIImage *separator = [self imageWithImage:[UIImage imageNamed:@"divider.png"] stretchToWidth:tableView.frame.size.width];
    [tableView setSeparatorColor:[UIColor colorWithPatternImage:separator]];
    
    
    
    
    
    return cell;
    }
    
    
    /**
     *  @brief  Helper method to stretch the divider by width to match the resolution
     *  @note Made general to be easily pulled out if functionality needs to be shared
     *
     *  @param sourceImage UIImage of the iamge to be stretched
     *  @param newWidth    width to stretch the image by
     *
     *  @return UIImage with width scretched to the new width
     */
    - (UIImage*)imageWithImage: (UIImage*) sourceImage stretchToWidth: (float) newWidth{
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, sourceImage.size.height));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, sourceImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    }
    
    
    
    
    #pragma mark -
    #pragma mark Hamburger Button Actions
    - (void)btnMovePanelRight:(id)sender
    {
    UIButton *button = sender;
    if(button.tag == 0){
    [delegate movePanelToOriginalPosition];
    }else if(button.tag == 1){
    [delegate movePanelRight];
    
    }
    }
    
    #pragma mark - Setting Button Actions
    
    -(void) btnMoveSettingPanelLeft:(id) sender
    {
    UIButton *button = sender;
    if(button.tag == 0){
    [delegate moveSettingPanelToOrginalPosition];
    }else if(button.tag == 1){
    [delegate moveSettingPanelLeft];
    
    }
    }
    
    
    #pragma mark -
    #pragma mark Table View delegate methods
    
    // Return the height for each cell
    -(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    return 90;//tableView.frame.size.height/_tableData.count;
    }
    
    
    // Sets the indentation for rows
    -(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    return 3;
    }
    
    // This method is run when the user taps the row in the tableview
    -(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if([delegate isViewFocused]){
    NSDictionary* tempDict = _tableData[indexPath.row];
    
    //Carrier Service Request
    //Check Package Hierarchy
    
    if (![tempDict[@"commingSoon"] boolValue]) {
    if ([tempDict[@"navItemName"] isEqualToString:@"Product Authentication" ]) {
    [self pushNavigation:[[ProductAuthMainViewController alloc] initWithNibName:@"ProductAuthMainViewController" bundle:nil]];
    }
    else if ([tempDict[@"navItemName"]  isEqualToString:@"Barcode Reader" ])
    {
    [self pushNavigation:[[BarcodeReaderViewController alloc] initWithNibName:@"BarcodeReaderViewController" bundle:nil]];
    }
    else if ([tempDict[@"navItemName"]  isEqualToString:@"User Scan History" ])
    {
    [self pushNavigation:[[UserScanHistoryViewController alloc] initWithNibName:@"UserScanHistoryViewController" bundle:nil]];
    }
    else if ([tempDict[@"navItemName"]  isEqualToString:@"Carrier Service Request" ])
    {
    [self pushNavigation:[[CSRViewController alloc] initWithNibName:@"CSRViewController" bundle:nil]];
    }
    else if ([tempDict[@"navItemName"]  isEqualToString:@"Driver Verification & History" ])
    {
    [self pushNavigation:[[DVViewController alloc] initWithNibName:@"DVViewController" bundle:nil]];
    }
    else if ([tempDict[@"navItemName"]  isEqualToString:@"Package Hierarchy" ])
    {
    [self pushNavigation:[[PackageHierarchyViewController alloc] initWithNibName:@"PackageHierarchyViewController" bundle:nil]];
    }
    
    else if ([tempDict[@"navItemName"]  isEqualToString:@"Asset Management" ])
    {
    UIStoryboard *storyboard;
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewControllerParent* myMapViewControllerParent = (MapViewControllerParent*)[storyboard instantiateViewControllerWithIdentifier:@"parentMap"];
    myMapViewControllerParent.bWasPushed = [[NSNumber alloc] initWithBool:TRUE];
    //[self pushNavigation:myMapViewControllerParent];
    [[self navigationController] pushViewController:myMapViewControllerParent animated:NO];
    }
    }
    
    }
    
    }
    
    /**
     *  @brief  Adds and displays input ViewController to list of view Controllers
     *
     *  @param viewController UIViewController to be added to controllers list
     */
    -(void)pushNavigation:(UIViewController*)viewController{
    //Need hide default back button
    viewController.navigationItem.hidesBackButton = YES;
    [[self navigationController] pushViewController:viewController animated:YES];
    }
    
    - (IBAction)CustomerServiceButtonPressed:(id)sender {
    if([delegate isViewFocused]){
    MyLog(@"Customer Service Button Pressed");
    
    CustomerServiceViewController * customerServiceViewController = [[CustomerServiceViewController alloc] initWithNibName:@"CustomerServiceViewController" bundle:nil];
    
    customerServiceViewController.navigationItem.hidesBackButton = YES;
    
    [[self navigationController] pushViewController:customerServiceViewController animated:YES];
    
    }
    }
    
    - (IBAction)TakePhotoButtonPressed:(id)sender {
    if([delegate isViewFocused]){
    MyLog(@"Take Photo Button Pressed");
    
    //TODO: do action here
    }
    }
    
    - (IBAction)NotificationsButtonPressed:(id)sender {
    if([delegate isViewFocused]){
    MyLog(@"Notifications Button Pressed");
    NotificationViewController *ptrNotifyViewController = [delegate getNotificationViewController];
    ptrNotifyViewController.parent = self;
    [[self navigationController] pushViewController:ptrNotifyViewController animated:YES];
    }
    }
    
    - (void)startListeningGps {
    if (!self.locationManager) {
    self.locationManager = [[CLLocationManager alloc] init];
    
    //we want every move.
    self.locationManager.headingFilter   = kCLHeadingFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;//kCLLocationAccuracyBest;
    CLLocationDistance distanceMoved     = 50;//5;
    self.locationManager.distanceFilter  = distanceMoved;
    self.locationManager.activityType    = CLActivityTypeFitness;
    
    //uncommented out on 4/8/2014
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.allowsBackgroundLocationUpdates = NO;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
    
    }else {
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
    }
    
    self.locationManager.delegate = self;
    #ifdef TESTING
    // Do any additional setup after loading the view, typically from a nib.
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 50, 100, 30);
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
#endif

}
*/

