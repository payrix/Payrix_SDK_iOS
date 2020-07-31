//
//  DemoAuthentication.swift
//  PayrixSDKDemo
//
//  Created by Steve Sykes on 7/22/20.
//  Copyright © 2020 Payrix. All rights reserved.
//

import UIKit
import PayCore

class DemoAuthentication: UIViewController, UITextFieldDelegate
{
  
  @IBOutlet weak var txtUserID: UITextField!
  @IBOutlet weak var txtUserPwd: UITextField!
  @IBOutlet weak var lblResults: UITextView!
  
  @IBOutlet weak var btnBack: UIButton!
  @IBOutlet weak var btnAuthenticate: UIButton!
  
  let sharedUtils = SharedUtilities.init()
  
  /**
  * Step 1: Instantiate the PayCoreMaster instance.  This class handles authentication.
  */
  let payCoreMaster = PayCoreMaster.sharedInstance
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    
    /*
    * Step 2:
    * a. Set the host URL
    * b. Set Demo - Sandbox mode
    */
    
    PayCoreSetAPIHostname(sharedUtils.pwlAPIHostName)
    sharedUtils.setDemoMode(modeKey: true)
    PayCoreSetTestMode(sharedUtils.getDemoMode() ?? true)
    
    lblResults.text = ""
    txtUserPwd.text = ""
    txtUserID.text = ""
    txtUserID.delegate = self
    txtUserPwd.delegate = self
  }
  
  @IBAction func goBack(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  

  /**
  **goAuthenticate**
  (Step 3)
  * This method listens for the Authenticate button to be tapped
  * The method verifies that valid input was entered and the proceeds
  * to authenticate with the gateway platform (Payrix).
  * The response from the gateway is via the Callback: didReceiveLoginResponse
  
  - Parameters:
    - sender: This represents the button object
  */
  @IBAction func goAuthenticate(_ sender: Any)
  {
    if doCheckValidInput()
    {
      lblResults.text = "Starting Authentication..."
      
      payCoreMaster.validateLoginCredentials(userName: txtUserID.text ?? "", password: txtUserPwd.text ?? "")
      {
        [weak self] (success, newSessionKey) in
        guard success, newSessionKey != nil
        else
        {
          self?.sharedUtils.showMessage(theController: self!, theTitle: "Authentication", theMessage: "Unexpected Error with Session Info... Retry")
          return
        }
                                  
        // Save session key
        self?.sharedUtils.setSessionKey(sessionKey: newSessionKey!)
        
        self?.updateLog(newMessage: "Session established...")
        
        // Retrieve Merchant Info
        self?.payCoreMaster.getMerchantId(sessionKey:newSessionKey!)
        {
          [weak self] (success, merchant, dba) in
          guard success, merchant != nil
          else
          {
            self?.sharedUtils.showMessage(theController: self!, theTitle: "Authentication", theMessage: "Unexpected Error with Merchant Info... Retry")
            return
          }
          
          self?.updateLog(newMessage: "Merchant retrieved...")
            
          // Save Merchant Info
          self?.sharedUtils.setMerchantID(merchantKey: merchant!)
          self?.sharedUtils.setMerchantDBA(merchantDBA: dba!)

          let logMsg = "Authentication Successful: \n" + "- Merchant ID: " + merchant! + "\n- Merchant DBA: " + dba!
          self?.updateLog(newMessage: logMsg)
          
          self?.hideKeyboard()
          return
        }
      }
    }
  }
  
  /**
  **updateLog**
  * This method updates the UI Log of authentication events
  - Parameters:
    - newMessage: The String message to be displayed
  */
  private func updateLog(newMessage: String)
  {
    var currentLog = lblResults.text
    currentLog = currentLog! + "\n" + newMessage
    lblResults.text = currentLog
  }
  
  private func doCheckValidInput() -> Bool
  {
    if (txtUserID.text == nil || txtUserID.text == "") || (txtUserPwd.text == nil || txtUserPwd.text == "")
    {
      return false
    }
    else
    {
      return true
    }
  }
  
  /**
  **textFieldShouldReturn**
  * This method handles jumping between UI fields when tapping the Next key.
  - Parameters:
    - textField: The current textfield selected
  - Returns:
    - Bool returns False to ignore normal key processing
  */
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
     // Try to find next responder
     if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
     {
        nextField.becomeFirstResponder()
     }
     else
     {
        // Not found, so remove keyboard.
        textField.resignFirstResponder()
     }
     // Do not add a line break
    
    if textField.tag == 102
    {
      goAuthenticate(self)
    }
     return false
  }
  
  
  func hideKeyboard()
  {
    view.endEditing(true)
  }
  
}
