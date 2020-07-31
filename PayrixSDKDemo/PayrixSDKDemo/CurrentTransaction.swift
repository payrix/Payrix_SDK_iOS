//
//  CurrentTransaction.swift
//
//  Copyright © 2018 Payrix. All rights reserved.
//

import UIKit

class CurrentTransaction: NSObject
{
  public static let sharedInstance = CurrentTransaction()
  override init()
  {
    self.merchantID = ""
  }
  
  var merchantID: String
  var merchantDBA: String?
  var transactionID: String?

  var amount: Double?
  var ccNumber: String?
  var ccCardType: SharedUtilities.CCType?
  var ccName: String?
  var ccEXP: String?
  var ccCVV: String?
  var zip: String?

  var tipPercentage: Int?
  var tipAbsoluteAmount: Double?
  var taxPercentage: Double?
  var signature: UIImage?
  var signatureBase64Encoded: String?
  var errorMessages: [String]?
  
  var receiptAID_4F: String?
  var receiptEMVChipInd: String?  // Swipe | Manual Entry | Chip
  var receiptAIDName_9F12: String?
  var receiptPINStmt: String?
  var receiptTVRCVR_95: String?
  var receiptApprovedDeclined: String?
  var receiptAuthApprovalCode: String?
  var receiptTSI_9B: String?
  var receiptCryptoCert_9F26: String?
  
//  init(merchantID: String)
//  {
//    self.merchantID = merchantID
//  }
//
//  // An init that copies only the fields we'd like to retain between transactions
//  init (fromTransaction txn: CurrentTransaction)
//  {
//    self.merchantID = txn.merchantID
//    self.merchantDBA = txn.merchantDBA
//    self.taxPercentage = txn.taxPercentage
//  }
  
}
