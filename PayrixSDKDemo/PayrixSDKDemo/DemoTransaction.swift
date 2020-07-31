//
//  DemoTransaction.swift
//  PayrixSDKDemo
//
//  Created by Steve Sykes on 7/22/20.
//  Copyright © 2020 Payrix. All rights reserved.
//

import UIKit
import PayCard
import PayCore

class DemoTransaction: UIViewController, PayCoreRDRTransMgrDelegate, PayCardRDRMgrDelegate, PayCardMasterDelegate
{
  @IBOutlet weak var btnBack: UIButton!
  @IBOutlet weak var btnStartTxn: UIButton!

  @IBOutlet weak var txtItemCost: UITextField!
  @IBOutlet weak var txtTaxRate: UITextField!
  @IBOutlet weak var txtTipAmt: UITextField!
  @IBOutlet weak var txtCardNumber: UITextField!
  
  @IBOutlet weak var vwCardDetails: UIView!
  @IBOutlet weak var txtCardHolder: UITextField!
  @IBOutlet weak var txtExpMM: UITextField!
  @IBOutlet weak var txtExpYY: UITextField!
  @IBOutlet weak var txtCVV: UITextField!
  @IBOutlet weak var txtZip: UITextField!
  
  @IBOutlet weak var lblCalcTotal: UILabel!
  @IBOutlet weak var lblProcessLog: UITextView!
  
  let sharedUtils = SharedUtilities.init()
  
  /** (Step 1)
  * Instantiate PayCardRDRMgr class - Which handles the native Bluetooth communications
  * Instantiate payCoreRDRTransMgr class - Which handles the card related transaction processing.
  * Instantiate PayCardMaster class - Which handles the transactional requests and responses with the card reader.
  * Instantiate PayCoreMaster class - Which handles the transactional requests and responses with the Payrix gateway API's.
  */
  var payCardMaster = PayCardMaster.sharedInstance
  var payCoreRDRTransMgr = PayCoreRDRTransMgr.sharedInstance
  var payCardRDRMgr = PayCardRDRMgr.sharedInstance
  var payCoreMaster = PayCoreMaster.sharedInstance
  
  var theMerchantID: String!
  var theMerchantDBA: String = ""
  
  var currentTransaction = CurrentTransaction.sharedInstance
  
  var btDeviceSerialNumber: String = ""
  var btDeviceUUID: String = ""
  var btDeviceManfg: String = ""
  
  var newTransDict = [String:Any]()
  var passedMessage:String?
  var cardReaderDeviceType = String()
  var debitCreditType:String? = String()
  
  var cardEntryMode:String = ""  // SWIPE or EMV or TAP
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    payCardRDRMgr.delegate = self
    payCoreRDRTransMgr.delegate = self
    payCardMaster.delegate = self
    
    
    let devManfg = sharedUtils.getBTManfg()
    let useManfg = PayCardSharedAttr.PayCardSupportedReaders.init(rawValue: devManfg ?? PayCardSharedAttr.PayCardSupportedReaders.reader_BBPOS.rawValue)
    
    /* (Step 2)
    * Start PayCardRDRMgr
    * This step establishes the necessary connections for Callback processing and
    * initializes key PayCard parameters.
    * PayCard handles communication with the Bluetooth reader device.
    * PayCardRDRMgr class handles native bluetooth, while PayCardMaster class handles transactional requests.
    */

    payCardRDRMgr.startPayCardRDRMgr(forDevice: useManfg)
  }
  
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    vwCardDetails.isHidden = true
    
    /*
    * Step X:
    * a. Set the host URL
    * b. Set Demo - Sandbox mode
    * TODO: Add to Documentation
    */
    
    PayCoreSetAPIHostname(sharedUtils.pwlAPIHostName)
    sharedUtils.setDemoMode(modeKey: true)
    PayCoreSetTestMode(sharedUtils.getDemoMode() ?? true)
    
    // Test Code with Hard Values to be Delete
    
//    txtCardNumber.text = "4111111111111111"
//    txtItemCost.text = "12.50"
//    txtTaxRate.text = "6.5"
//    txtTipAmt.text = "2.00"
//
//    txtCardHolder.text = "John Doe"
//    txtExpMM.text = "12"
//    txtExpYY.text = "23"
//    txtCVV.text = "357"
//    txtZip.text = "33027"
    
    // ****************************************
    
    doSetCurrentTransaction()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    payCardRDRMgr.delegate = self
  }
  
  /**
  **doSetCurrentTransaction**
  (Step 3a)
  This method prepares to perform a transaction.
  The demo app uses an object called CurrentTransaction to capture and hold the payment transaction information
  throughout the lifecycle of the transaction.
  In the demo, information created during the Authentication and BT Scan steps are used here and elsewhere in this class.
  */
  private func doSetCurrentTransaction()
  {
    theMerchantDBA = sharedUtils.getMerchantDBA() ?? ""
    theMerchantID = sharedUtils.getMerchantID()
    
    if theMerchantID != nil
    {
      self.currentTransaction.merchantID = theMerchantID
      self.currentTransaction.merchantDBA = theMerchantDBA
      self.currentTransaction.taxPercentage = 0.00
    }
    else
    {
      updateLog(newMessage: "Authenticate before processing a transaction")
    }
  }
  
  
  /**
  **doBuildTxnAmts**
  (Step 3b)
  This is a utility method to calculate values as needed and then store them in the
  CurrentTransaction object.
  */
  private func doBuildTxnAmts()
  {
    let fltCost = Float(String(txtItemCost.text!))
    var fltTaxRate = Float(String(txtTaxRate.text!))
    fltTaxRate = fltTaxRate! / 100.00
    let fltTip = Float(String(txtTipAmt.text!))
    
    self.currentTransaction.amount = Double((fltCost!*100).rounded()/100)
    self.currentTransaction.taxPercentage = Double(fltTaxRate!)
    self.currentTransaction.tipAbsoluteAmount = Double((fltTip!*100).rounded()/100)
    self.currentTransaction.tipPercentage = 0
    
    let calcTax = self.currentTransaction.amount! * self.currentTransaction.taxPercentage!
    let calcTotal = self.currentTransaction.amount! + calcTax + self.currentTransaction.tipAbsoluteAmount!
    
    lblCalcTotal.text = String(format: "%.2f", calcTotal)
    
    let logMsg = "Starting Transaction Processing: \nTotal Amount: " + String(format: "%.2f", calcTotal)
    updateLog(newMessage: logMsg)
  }
  

  
  @IBAction func goBack(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func goCardEntry(_ sender: Any)
  {
    // A card number was entered
    vwCardDetails.isHidden = false
  }
  
  
  /**
  **goStartTxn**
  * (Step 4)
   This method listens for the Start Transaction button to be tapped.
   The information provided is used to start transaction processing.
   In this demo if the Card Number is the provided then the transaction is managed as
   a manual entry transaction.  Otherwise the transaction will require a BT card reader be used.
  */
  @IBAction func goStartTxn(_ sender: Any)
  {
    hideKeyboard()
    lblProcessLog.text = ""
    
    doBuildTxnAmts()
    
    payCardMaster.delegate = self
    
    if (txtCardNumber.text == nil) || (txtCardNumber.text == "")
    {
      doPrepCardReader()
      // Follow Steps: 5a - 11a
    }
    else
    {
      doManualTxn()
      // Follow Steps: 5b - 6b
    }
  }
  
  
  /**
  **doPrepCardReader**
  * (Step 5a)
   Prepare the card reader by connecting to the Bluetooth Reader.
   If the reader connects successfully then the transaction processing will be triggered
  */
  private func doPrepCardReader()
  {
    payCardRDRMgr.delegate = self
    payCardMaster.delegate = self
    
    btDeviceSerialNumber = sharedUtils.getBTReader()!
    payCardRDRMgr.connectBTReader(useSerialNumber: btDeviceSerialNumber)
    
  }
  
  /**
  **didSuccessfulBTConnect**
  (Step 6a)
  This is the callback for the BT Connect request.  Once the device is connected the transaction can be processed.
  */
  public func didSuccessfulBTConnect()
  {
    // Handle Successful Connection
    updateLog(newMessage: "BT Device: " + btDeviceSerialNumber + " Connected")
    doCardReaderTxn()
  }
  
  /**
  **didReceiveBTScanTimeOut**
  This is the callback for the BT Connect request.
  */
  public func didReceiveBTScanTimeOut()
  {
    updateLog(newMessage: "The automatic connection of the Card Reader was unsuccessful.")
  }
  
  /**
  **doCardReaderTxn**
  * (Step 7a)
   Started Card Reading (Swipe) process with PayCard doReadCard request passing the transaction information.
   Callbacks are:  didReceiveReaderModeUpdate, didReceiveSwipeSuccess, and didReceiveCardReaderIssue
  */
  private func doCardReaderTxn()
  {
    cardEntryMode = "SWIPE"
    btDeviceManfg = sharedUtils.getBTManfg() ?? PayCardSharedAttr.PayCardSupportedReaders.reader_BBPOS.rawValue
    var useManfg: PayCardSharedAttr.PayCardSupportedReaders!
    useManfg = PayCardSharedAttr.PayCardSupportedReaders.init(rawValue: btDeviceManfg)
    
    let calcTax = self.currentTransaction.amount! * self.currentTransaction.taxPercentage!
    let calcTotal = self.currentTransaction.amount! + calcTax + self.currentTransaction.tipAbsoluteAmount!
    
    payCardMaster.doReadCard(withTotalAmt: calcTotal, withTax: calcTax, withTip: self.currentTransaction.tipAbsoluteAmount!, withCurrency: "USD", withURL: sharedUtils.getURL(theURI: ""), posMode: PayCardSharedAttr.PayCardDeviceMode.cardDeviceMode_Swipe, forDevice: useManfg)
  }
  
  
  /**
  **doManualTxn**
  * (Step 5b)
   Prepare the transaction for processing using the manually entered card information.
  */
  private func doManualTxn()
  {
    currentTransaction.ccName = txtCardHolder.text
    currentTransaction.ccEXP = txtExpMM.text! + txtExpYY.text!
    currentTransaction.ccCVV = txtCVV.text
    currentTransaction.zip = txtZip.text
    currentTransaction.ccNumber = txtCardNumber.text
    
    determineCardType()
    doProcessManualCard()
  }
  
  
  func determineCardType()
  {
    let inputValue = currentTransaction.ccNumber ?? ""
      currentTransaction.ccCardType = nil
      for ccType in SharedUtilities.ccTypeRegex.keys {
          if let regex = SharedUtilities.ccTypeRegex[ccType],
             let _ = inputValue.range(of: regex,
                                      options: .regularExpression) {
              currentTransaction.ccCardType = ccType
          }
      }
  }
  
  
  /**
  **doProcessManualCard**
  * (Step 6b)
   This method prepares and starts the manual card processing using the
   PayCoreMaster method: doManualCardTransaction
   
   The callback is: didReceiveTransactionResponse
  */
  private func doProcessManualCard()
  {
    let useCardType:PayCoreCCType?
    if let useCCtype = currentTransaction.ccCardType
    {
      useCardType = PayCoreCCType(rawValue: (useCCtype.rawValue))
    }
    else
    {
      useCardType = nil
    }
    
    var useTax = Double()
    if let dblTax = currentTransaction.taxPercentage
    {
      useTax = dblTax / 100.00
    }
    
    currentTransaction.receiptEMVChipInd = "Manual Entry"
    
    let sessionKey = sharedUtils.getSessionKey()
    let calcTax = self.currentTransaction.amount! * self.currentTransaction.taxPercentage!
    let calcTotal = self.currentTransaction.amount! + calcTax + self.currentTransaction.tipAbsoluteAmount!
    
    payCoreMaster.processTransaction(merchantID: currentTransaction.merchantID,
                                     sessionKey: sessionKey, amount: currentTransaction.amount,
                                       taxPercent: useTax,
                                       tipPercent: currentTransaction.tipPercentage,
                                       tipAmt: currentTransaction.tipAbsoluteAmount,
                                       calcTotAmt: calcTotal,
                                       ccName: currentTransaction.ccName,
                                       ccNumber: currentTransaction.ccNumber,
                                       ccCardType: useCardType,
                                       ccCVV: currentTransaction.ccCVV,
                                       ccExp: currentTransaction.ccEXP,
                                       ccOrigin: PayCoreTxnOrigin.eCommerceSystem,
                                       zip: currentTransaction.zip)
    {
      [weak self] (success, txnID, txnAuth, errors) in
      
      if !success
      {
        self?.currentTransaction.errorMessages = errors
        self?.currentTransaction.transactionID = nil
        self?.currentTransaction.receiptAuthApprovalCode = nil
        self?.updateLog(newMessage: "** Transaction Processing Failed **")
        return
      }
       
      self?.currentTransaction.transactionID = txnID
      self?.currentTransaction.receiptAuthApprovalCode = txnAuth
      self?.updateLog(newMessage: "- Signature can be captured at this point -")
      self?.updateLog(newMessage: "** Transaction Completed Successfully **")
    }
  }
  
  
  /**
   **didReceiveReaderModeUpdate**
   (Step 8a)
   This method handles the callback from PayCard that is drives most card management processes including notifying when the device is waiting for an action such as a card swipe, insert, or tap.
   
   - Parameters:
     - currentMode: An indicator of type PayCardDeviceMode.
   
   */
  func didReceiveReaderModeUpdate(currentMode: PayCardSharedAttr.PayCardDeviceMode)
  {
    switch currentMode
    {
    case .cardDeviceMode_Swipe:
      updateLog(newMessage: "Please Swipe Card")
      break
      
    case .cardDeviceMode_Insert:
      updateLog(newMessage: "Please Insert Card")
      break
      
    case .cardDeviceMode_Tap:
      updateLog(newMessage: "Please Tap Card")
      break
      
    case .cardDeviceMode_SwipeOrInsert:
      updateLog(newMessage: "Please Swipe or Insert Card")
      break
      
    case .cardDeviceMode_SwipeOrTap:
      updateLog(newMessage: "Please Swipe or Tap Card")
      break
      
    case .cardDeviceMode_SwipeOrInsertOrTap:
      updateLog(newMessage: "Please Swipe, Insert or Tap Card")
      break
      
    case .cardDeviceMode_InsertNotSwipe:
      updateLog(newMessage: "Please Insert Card (Do Not Swipe)")
      break
      
    case .cardDeviceMode_ManualEntry:
      updateLog(newMessage: "Manual Entry Required. Tap KeyPad button below")
      break
      
    case .cardDeviceMode_Confirm:
      updateLog(newMessage: "Confirming...")
      payCardMaster.doCardConfirm(confirmed: true)
      break
      
    default:
      updateLog(newMessage: "Unknown Error: \(currentMode)")
      break
    }
  }
  
  
  /**
  **didReceiveSwipeSuccess**
  (Step 9a)
  This callback handles the successful completion of the card swipe / reading process.
  The information is then sent to PayCore for gateway transaction processing.
  
  - Parameters:
    - gateWayData: A dictionary (Key-Value Pair) of card transaction data from the card reader
    - cardInfo:    A dictionary of card data.
  */
  func didReceiveSwipeSuccess(gateWayData: [String : Any], cardInfo: [String : String?])
  {
    updateLog(newMessage: "Processing Payment...")

    // Move to Post Host Processing.  Reason: Some device only pass Track Data.
    let useMonth = cardInfo["cardExpiryMonth"] ?? "--"
    let useYear = cardInfo["cardExpiryYear"] ?? "--"

    self.currentTransaction.ccName = cardInfo["cardHolderName"] ?? "****"
    self.currentTransaction.ccEXP = useMonth! + useYear!

    if let cardNumber = cardInfo["cardNumber"]
    {
      self.currentTransaction.ccNumber = cardNumber
    }

    newTransDict = gateWayData

    if let cardType = cardInfo["cardType"]
    {
      if cardType != "UNKNOWN"
      {
        debitCreditType = cardType
        newTransDict["type"] = sharedUtils.bldCCType(cardType: cardType!)?.rawValue
      }
    }
    
    newTransDict["merchant"] = self.currentTransaction.merchantID
    newTransDict["origin"] = PayCoreTxnOrigin.creditCardTerminal
    
    if let useEntryMode = gateWayData["posEntryMode"] as? String
    {
      let convertedEntryMode = sharedUtils.convertIndModeToPayrixEntryMode(industryMode: useEntryMode)
      newTransDict["posentrymode"] = convertedEntryMode
    }
    else
    {
      newTransDict["posentrymode"] = PayCardSharedAttr.readerEntryMode.read_MagneticStrip.rawValue
    }
    
    self.currentTransaction.receiptEMVChipInd = "Swipe"
    cardEntryMode = "SWIPE"
    doCardToCoreTransaction(entryMode: "SWIPE")
  }
  
  /**
  **doCardToCoreTransaction**
  (Step 10a)
  This method handles engaging PayCoreMaster class for transaction processing with the Payrix gateway.
  The method called is: doCardReaderTransaction
  The callbacks for this method call is: didReceiveTransactionResponse
  
  - Parameters:
    - entryMode: A String describing the entry mode
  */
  private func doCardToCoreTransaction(entryMode: String)
  {
    cardEntryMode = entryMode
    if let useSessionKey = sharedUtils.getSessionKey()
    {
      payCoreRDRTransMgr.doCardRDRTransaction(withGatewayDict: newTransDict, withSessionKey: useSessionKey, withURL: sharedUtils.getURL(theURI: "/txns"))
      updateLog(newMessage: "Transaction being processed at a Payrix Gateway.")
    }
    else
    {
      updateLog(newMessage: "The Session has Timed out. Reauthenticate and retry...")
    }
  }
  
  
  /**
  **didReceiveTransactionSuccess**
  (Step 11a)
  This callback handles the response from the Payrix gateway for the doCardReaderTransaction or doManualCardTransaction requests.
  This is the last step in the transaction processing.
  
  - Parameters:
    - response: An PayCoreTransResponse object containing the response from the gateway.
    - coreStatus: The status of the transaction
  */
  func didReceiveTransactionSuccess(response: PayCoreTransResponse, coreStatus: CoreStatus)
  {
    updateLog(newMessage: "Payment Completed Successfully... APPROVED")
    
    if let ccNum = response.payments!.number
    {
      self.currentTransaction.ccNumber = ccNum
    }
    else
    {
      self.currentTransaction.ccNumber = "----"
    }
  
    if let useType = debitCreditType
    {
      if let useCardType = sharedUtils.bldCCType(cardType: useType)
      {
        self.currentTransaction.ccCardType = useCardType
      }
    }
  
    self.currentTransaction.receiptApprovedDeclined = "APPROVED"
    self.currentTransaction.ccName = (response.firstName ?? " ") + " " + (response.lastName ?? " ")
    self.currentTransaction.ccEXP = response.expiration ?? "    "
    self.currentTransaction.transactionID = response.idString
    self.currentTransaction.receiptAuthApprovalCode = response.authorization
    
    if let aCCType = response.payments?.method
    {
      let cctypeVal = SharedUtilities.CCType.init(rawValue: aCCType)
       self.currentTransaction.ccCardType = cctypeVal
    }

    self.updateLog(newMessage: "Demo Transaction Processing has completed.")
    print("Demo Transaction Processing has completed.")
    refreshLogInfo()
  }
  
  /**
   **didReceiveTransactionFailed**
   
   This method handles the callback from PayCore failed processing of a transaction.  The method handles MSR (Swipe), Chip (Insert), and Contactless (Tap).
   
   - Parameters:
     - response: An object defined by PayCoreTransResponse that contains the API Transaction response.
     - coreStatus: An object defined by CoreStatus that contain a transaction status code.
   
   */
  func didReceiveTransactionFailed(response: PayCoreTransResponse, theErrors: [String], coreStatus: CoreStatus)
  {
    updateLog(newMessage: "Payment Failed.. DECLINED")
    var useMsg = ""
    var usePrefix = ""
    if theErrors.count >= 2
    {
      usePrefix = " - "
    }

    for anError in theErrors
    {
      useMsg.append("\(usePrefix)\(anError) \n")
    }
    var forceArray = [String]()
    forceArray.append(useMsg)
    self.currentTransaction.errorMessages = forceArray
    
    if let ccNum = response.payments!.number
    {
      self.currentTransaction.ccNumber = ccNum
    }
    else
    {
      self.currentTransaction.ccNumber = "----"
    }
    
    if let useType = debitCreditType
    {
      if let useCardType = sharedUtils.bldCCType(cardType: useType)
      {
        self.currentTransaction.ccCardType = useCardType
      }
    }
    
    self.currentTransaction.receiptApprovedDeclined = "DECLINED"
    self.currentTransaction.ccName = (response.firstName ?? " ") + " " + (response.lastName ?? " ")
    self.currentTransaction.ccEXP = response.expiration ?? "    "
    self.currentTransaction.transactionID = response.idString
    
    if let aCCType = response.payments?.method
    {
      let cctypeVal = SharedUtilities.CCType.init(rawValue: aCCType)
      self.currentTransaction.ccCardType = cctypeVal
    }
    
    self.updateLog(newMessage: "Demo Transaction Processing has completed.")
    print("Demo Transaction Processing has completed.")
    refreshLogInfo()
  }
  
  
  func hideKeyboard()
  {
    view.endEditing(true)
  }
  
  private func updateLog(newMessage: String)
  {
    var currentLog = lblProcessLog.text
    currentLog = currentLog! + "\n" + newMessage
    lblProcessLog.text = currentLog
  }
  
  func refreshLogInfo()
  {
    self.view.setNeedsLayout()
    self.lblProcessLog.setNeedsDisplay()
    
  }
  
}
