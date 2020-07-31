//
//  DemoStart.swift
//  PayrixSDKDemo
//
//  Created by Steve Sykes on 7/20/20.
//  Copyright © 2020 Payrix. All rights reserved.
//

import UIKit

class DemoStart: UIViewController
{
  @IBOutlet weak var btnAuthenticate: UIButton!
  @IBOutlet weak var btnScanReader: UIButton!
  @IBOutlet weak var btnPaymentTxn: UIButton!
  
  @IBOutlet weak var lblProcessingLog: UITextView!
  
  let sharedUtils = SharedUtilities.init()
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    if !sharedUtils.checkNetworkConnection()
    {
      sharedUtils.showMessage(theController: self, theTitle: "Payrix SDK Demo App", theMessage: "The Network Connection is Not Available; Resolve and Retry")
      btnPaymentTxn.isHidden = true
      btnScanReader.isHidden = true
      btnAuthenticate.isHidden = true
    }
    else
    {
      btnPaymentTxn.isHidden = false
      btnScanReader.isHidden = false
      btnAuthenticate.isHidden = false
    }
  }
  
  /**
  **goAuthenticate**
  The method branches over to the Authenticate UI for processing
  - Parameters:
    - sender: The button view object
  */
  @IBAction func goAuthenticate(_ sender: Any)
  {
    performSegue(withIdentifier: "SegToAuth", sender: self)
  }
  
  /**
  **goScanReader**
  The method branches over to the Bluetooth Scan and Set UI for processing
  - Parameters:
    - sender: The button view object
  */
  @IBAction func goScanReader(_ sender: Any)
  {
    performSegue(withIdentifier: "SegToScan", sender: self)
  }
  
  /**
  **goPaymentTxn**
  The method branches over to the Payment Transaction UI for processing
  - Parameters:
    - sender: The button view object
  */
  @IBAction func goPaymentTxn(_ sender: Any)
  {
    performSegue(withIdentifier: "SegToTxn", sender: self)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    guard let segID = segue.identifier else { return }
    if segID == "SegToAuth"
    {
      // Prep for Authentication Processing
      let _ = segue.destination as! DemoAuthentication
    }
    else if segID == "SegToScan"
    {
      // Prep for Bluetooth Scanning Processing
      let _ = segue.destination as! DemoScanBT
    }
    else if segID == "SegToTxn"
    {
        // Prep for Transaction Processing
        let _ = segue.destination as! DemoTransaction
    }
  }
}
