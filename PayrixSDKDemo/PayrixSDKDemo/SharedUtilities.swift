//
//  SharedUtilities.swift
//  PayrixSDKDemo
//
//  Created by Steve Sykes on 7/22/20.
//  Copyright © 2020 Payrix. All rights reserved.
//

import UIKit
import PayCore
import PayCard

class SharedUtilities: NSObject
{
  // Singleton for SharedUtilities
  public static let sharedInstance = SharedUtilities()
  override init() {}
  
  let merchantIDKey:String = "merchantID"
  let merchantDBAKey = "merchantDBA"
  let lastUsedTaxRateKey = "lastUsedTaxRate"

  // Sign In Keys
  let userNameDefaultsKey = "UserName"
  let sessionKeyDefaultsKey = "Session"

  // Default URLs
  public let pwlAPIHostName = "api.payrix.com"
  public let pwlForgotPasswordURL = "https://portal.payrix.com"

  // The Demo Mode Key
  let demoModeKey = "com.Payrix.DemoMode"

  // BT Device Key
  let btDeviceKey = "CurrentBTReader"
  let btManufacturerKey = "CurrentBTManfg"
  
  let userDefaults = UserDefaults.standard
  
  // CC Type image map
  static let ccTypeNames = [CCType.AmericanExpress : "Amex",
                            CCType.Discover : "Discover",
                            CCType.MasterCard : "Master Card",
                            CCType.Visa : "Visa"]

  static let ccTypeImages = [CCType.AmericanExpress : "Amex",
                             CCType.Discover : "Discover",
                             CCType.MasterCard : "MasterCard",
                             CCType.Visa : "Visa"]

  // Regex expressions to match CC type by CC number
  static let ccTypeRegex = [CCType.AmericanExpress : "^3[47][0-9]",
                             CCType.Discover : "^6[0-9]",
                             CCType.MasterCard : "^(5[1-5][0-9])|^(2[2-7][0-9])",
                             CCType.Visa : "^4[0-9]"]

  // How many digits required for each CC type?
  static let ccTypeDigits = [CCType.AmericanExpress : 15,
                             CCType.Discover : 16,
                             CCType.MasterCard : 16,
                             CCType.Visa : 16]
  static let ccDigitsDefault = 16
  
  // Credit Card types
  public enum CCType: Int {
      case AmericanExpress = 1
      case Visa = 2
      case MasterCard = 3
      case DinersClub = 4
      case Discover = 5
  }
  
  public func setSessionKey(sessionKey: String)
  {
    userDefaults.set(sessionKey, forKey: sessionKeyDefaultsKey)
  }
  
  public func getSessionKey() -> String?
  {
    let foundValue = userDefaults.string(forKey: sessionKeyDefaultsKey)
    return foundValue
  }
  
  
  public func setDemoMode(modeKey: Bool)
  {
    userDefaults.set(modeKey, forKey: demoModeKey)
  }
  
  public func getDemoMode() -> Bool?
  {
    let foundValue = userDefaults.bool(forKey: demoModeKey)
    return foundValue
  }
  
  public func setMerchantID(merchantKey: String)
  {
    userDefaults.set(merchantKey, forKey: merchantIDKey)
  }
  
  public func getMerchantID() -> String?
  {
    let foundValue = userDefaults.string(forKey: merchantIDKey)
    return foundValue
  }
  
  public func setMerchantDBA(merchantDBA: String)
  {
    userDefaults.set(merchantDBA, forKey: merchantDBAKey)
  }
  
  public func getMerchantDBA() -> String?
  {
    let foundValue = userDefaults.string(forKey: merchantDBAKey)
    return foundValue
  }
  
  public func setBTReader(btReaderKey: String)
  {
    userDefaults.set(btReaderKey, forKey: btDeviceKey)
  }
  
  public func getBTReader() -> String?
  {
    let foundValue = userDefaults.string(forKey: btDeviceKey)
    return foundValue
  }
  
  public func setBTManfg(btManfgKey: String)
  {
    userDefaults.set(btManfgKey, forKey: btManufacturerKey)
  }
  
  public func getBTManfg() -> String?
  {
    let foundValue = userDefaults.string(forKey: btManufacturerKey)
    return foundValue
  }
  
  func bldCCType(cardType:String) -> CCType?
  {
    switch cardType.uppercased()
    {
    case "AMEX":
      return CCType.AmericanExpress
    case "DISCOVER":
      return CCType.Discover
    case "MASTERCARD":
      return CCType.MasterCard
    case "VISA":
      return CCType.Visa
    case "DINERSCLUB":
      return CCType.DinersClub
    default:
      break
    }
    return nil
  }
  
  func convertIndModeToPayrixEntryMode(industryMode: String) -> String
  {
    var retPayrixMode = ""
    switch industryMode
    {
      case PayCardSharedAttr.industryPOSEntryMode.ind_Manual_Entry.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_Manual_Entry.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_MagneticStrip.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_MagneticStrip.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_EMV_ChipCard.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_EMV_ChipCard.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_Contactless_EMV.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_Contactless_EMV.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_Fallback_Magnetic.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_Fallback_Magnetic.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_MagneticStripFromTrack2.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_Track2.rawValue
      
      case PayCardSharedAttr.industryPOSEntryMode.ind_ContactlessMagneticStrip.rawValue:
        retPayrixMode = PayCardSharedAttr.readerEntryMode.read_Contactless_EMV.rawValue
      
      default:
        retPayrixMode = industryMode
    }
    return retPayrixMode
  }
  
  public func getURL(theURI: String) -> String
  {
    var useURL = ""
//    if getDemoMode() ?? true
//    {
      useURL = "https://test-" + pwlAPIHostName + theURI
//    }
//    else
//    {
//      useURL = "https://" + pwlAPIHostName + theURI
//    }
    return useURL
  }
  
  
  public func showMessage(theController: UIViewController, theTitle: String, theMessage: String)
  {
    let msgAlertController = UIAlertController(title: theTitle, message: theMessage, preferredStyle: UIAlertController.Style.alert)
    let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
    { (alert) in
    }
    msgAlertController.addAction(ok)
    theController.present(msgAlertController, animated: true, completion: nil)
  }
  
  
  public func checkNetworkConnection() -> Bool
  {
    if (Network.reachability?.isReachable) == false
    {
      return false
    }
    else
    {
      return true
    }
  }
  
}

