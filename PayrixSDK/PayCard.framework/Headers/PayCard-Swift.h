// Generated by Apple Swift version 5.3.1 effective-4.2 (swiftlang-1200.0.41 clang-1200.0.32.8)
#ifndef PAYCARD_SWIFT_H
#define PAYCARD_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import ObjectiveC;
#endif

#import <PayCard/PayCard.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="PayCard",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC7PayCard21DeviceControllerBBPOS")
@interface DeviceControllerBBPOS : NSObject <BBDeviceControllerDelegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
/// <em>onBTReturnScanResults</em>
/// The callback triggered by bbPOS startBTScan. This callback delivers an array of found bluetooth peripherals.
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     devices: Returned Peripheral devices
///   </li>
/// </ul>
- (void)onBTReturnScanResults:(NSArray * _Null_unspecified)devices;
/// <em>onBTConnected</em>
/// The callback triggered by bbPOS connectBT. This callback delivers the object that was connected.
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     connectedDevice: Returned Connected Object
///   </li>
/// </ul>
- (void)onBTConnected:(NSObject * _Null_unspecified)connectedDevice;
- (void)onBTScanTimeout;
/// <em>onBTDisconnected</em>
/// The callback triggered by bbPOS disconnectBT.
- (void)onBTDisconnected;
- (void)onReturnDeviceInfo:(NSDictionary * _Null_unspecified)deviceInfo;
- (void)onError:(BBDeviceErrorType)errorType errorMessage:(NSString * _Nonnull)errorMessage;
@end



/// <em>DeviceControllerIDTCH is the Primary API Access Point for using the PayCard Device Driver for ID Tech for Device Processing</em>
/// This is a Singleton Design Pattern so only 1 instance should ever existing to process
/// any requests from other classes.
/// <ul>
///   <li>
///     IDT_VP3300_Delegate is the name ID Tech Protocol for managing Callbacks
///   </li>
/// </ul>
SWIFT_CLASS("_TtC7PayCard21DeviceControllerIDTCH")
@interface DeviceControllerIDTCH : NSObject <IDT_VP3300_Delegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
/// <em>deviceMessage</em>
/// This method is callback from ID Tech that is triggered when an general information message is returned from the device.
/// The message is then returned to PayCard using callback: didReturnDevError.
/// \param message A string containing the general information message.
///
- (void)deviceMessage:(NSString * _Null_unspecified)message;
/// <em>deviceConnected</em>
/// This method is callback from ID Tech that is triggered when a BT Device is Connected.
/// This method is used by 2 processes.  The standard BT Connect process and the BT Reset / Reconnect process.
/// If it is a standard Bt Connect then is PayCard notified of the successful connection using the callback: didBTConnect.
/// Otherwise for a reset the appropriate action or non-action is taken.
- (void)deviceConnected;
/// <em>deviceDisconnected</em>
/// This method is callback from ID Tech that is triggered when a BT Device is Disconnected.
/// This method is used by 2 processes.  The standard BT Disconnect process, or when the device is disconnected by the user and the BT Reset / Reconnect process.
/// If it is a standard Bt Disconnect then PayCard is notified of the disconnection using the callback: didBTDisconnect.
/// Otherwise for a reset the appropriate action or non-action is taken.
- (void)deviceDisconnected;
@end



/// <em>PDeviceLoader is the for dynamically loading Card Reader Device Drivers</em>
/// This class accepts in the brand of the reader to be used. The class then loads only the device classes (drivers) to support
/// the specific device.
SWIFT_CLASS("_TtC7PayCard13PDeviceLoader")
@interface PDeviceLoader : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


/// <em>PayCardMaster is the Primary API Access Point for using the PayCard Transaction functions</em>
/// This is a Singleton Design Pattern so only 1 instance should ever existing to process
/// any requests from other classes.
SWIFT_CLASS("_TtC7PayCard13PayCardMaster")
@interface PayCardMaster : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


/// <em>PayCardRDRMgr is the Primary API Access Point for using the PayCard Bluetooth & Audio functions</em>
/// This is a Singleton Design Pattern so only 1 instance should ever existing to process
/// any requests from other classes.  The class handles the direct and indirect communication with the Core Bluetooth services
/// and Audio services provided by Apple. Some services provided by AnyPay are also manage in this class.
/// The iOS Notification Center is used to notify other classes, including user App, of changes in the state of bluetooth devices.
SWIFT_CLASS("_TtC7PayCard13PayCardRDRMgr")
@interface PayCardRDRMgr : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@class CBCentralManager;
@class CBPeripheral;
@class NSNumber;

@interface PayCardRDRMgr (SWIFT_EXTENSION(PayCard)) <CBCentralManagerDelegate, CBPeripheralDelegate>
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
@end


/// ** SharedDriverAttr contains the shared attributes used the PayCard Device Drivers **
SWIFT_CLASS("_TtC7PayCard16SharedDriverAttr")
@interface SharedDriverAttr : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC7PayCard26TransactionControllerBBPOS")
@interface TransactionControllerBBPOS : NSObject <BBDeviceControllerDelegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
/// <em>onWaitingForCard</em>
/// This method is a listener to handle callback for bbPOS startEMV. It will be engaged if the user needs to respond to
/// the reader device.  A callback to the user App as method: didReceiveReaderModeUpdate
/// <ul>
///   <li>
///     Paramater:
///   </li>
///   <li>
///     checkCardMode: The device status / mode of type BBDeviceCheckCardMode
///   </li>
/// </ul>
- (void)onWaitingForCard:(BBDeviceCheckCardMode)checkCardMode;
- (void)onRequestDisplayText:(BBDeviceDisplayText)displayMessage;
/// <em>onReturnCheckCardResult</em>
/// This method is a listener to handle Callback from bbPOS for magnetic strip event.
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     result: A result of type BBDeviceCheckCardResult
///   </li>
///   <li>
///     cardData: A dictionary containing returned card data depending on the result.
///   </li>
/// </ul>
- (void)onReturnCheckCardResult:(BBDeviceCheckCardResult)result cardData:(NSDictionary * _Null_unspecified)cardData;
/// <em>onRequestFinalConfirm</em>
/// This method is a listener to handle Callback from bbPOS after the initial card processing.
/// This callback is triggered when the card swipe / insert process has occured,
/// and is awaiting transaction confirmation.
- (void)onRequestFinalConfirm;
/// <em>onRequestOnlineProcess</em>
/// This method serves as a listener to catch request from the device to do Online Host
/// processing as required by the EMV process. The device sends data in TLV (tag-length-value) format and
/// that information is sent to the caller App (requestForHostEMVProcess). Once processed the
/// App returns the response (responseFromHostEMVProcess)
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     tlv: Device transaction data in TLV (tag-length-value) format
///   </li>
/// </ul>
- (void)onRequestOnlineProcess:(NSString * _Null_unspecified)tlv;
/// <em>onReturnBatchData</em>
/// This method serves as a listener to catch response from the device after the EMV transaction
/// is complete. The device sends data in TLV (tag-length-value) format and
/// that information is sent to the caller App (didReceiveFinalEMVBatchData).
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     tlv: Device transaction data in TLV (tag-length-value) format
///   </li>
/// </ul>
- (void)onReturnBatchData:(NSString * _Nonnull)tlv;
/// <em>onReturnTransactionResult</em>
/// This method serves as a listener to catch response from the device after the EMV transaction
/// is complete. The device sends the resulting status of the transaction.  The method takes that
/// result and responds to the calling App via callback (didCompleteEMVCardTransaction) with
/// success (true) or failure (false) and the Results from the device.
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     result: The transaction result from the Device of type BBDeviceTransactionResult.
///   </li>
/// </ul>
- (void)onReturnTransactionResult:(BBDeviceTransactionResult)result;
- (void)onError:(BBDeviceErrorType)errorType errorMessage:(NSString * _Nonnull)errorMessage;
- (void)onReturnDeviceInfo:(NSDictionary * _Null_unspecified)deviceInfo;
@end


@class IDTMSRData;
@class IDTEMVData;

/// <em>TransactionControllerIDTCH is the Primary API Access Point for using the PayCard Device Driver for ID Tech for Transaction Processing</em>
/// This is a Singleton Design Pattern so only 1 instance should ever existing to process
/// any requests from other classes.
/// <ul>
///   <li>
///     IDT_VP3300_Delegate is the name ID Tech Protocol for managing Callbacks
///   </li>
/// </ul>
SWIFT_CLASS("_TtC7PayCard26TransactionControllerIDTCH")
@interface TransactionControllerIDTCH : NSObject <IDT_VP3300_Delegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
/// <em>deviceConnected</em>
/// This is the Callback from the ID Tech SDK upon the completion of a successful connection to the Bluetooth device.
/// This device connect request is part of the device reset process, and not part of the normal BT Connection process managed in the DeviceController.
/// When the device is connected the reset of the device is completed and the transaction can be processed.
- (void)deviceConnected;
/// <em>deviceMessage</em>
/// This is the Callback from the ID Tech SDK when an Informative message is returned.
/// Then the message is sent to PayCard using the callback: didReceiveMessage
/// \param message The Transaction Data in a Key-Value Pair Container (Dictionary)
///
- (void)deviceMessage:(NSString * _Null_unspecified)message;
/// <em>swipeMSRData</em>
/// This is the Callback from the ID Tech SDK for legacy Callbacks.
/// \param cardData Swipe data in object IDTMSRData.
///
- (void)swipeMSRData:(IDTMSRData * _Null_unspecified)cardData;
/// <em>emvTransactionData</em>
/// This is the Callback from the ID Tech SDK for EMV Callbacks.
/// This method handles both encrypted MSR and EMV transactions.  This replaced the above legacy methods.
/// The method uses a combination of ResultCodeV2 (supercedes original ResultCode) and errorCode to determine the
/// next action.  Unfortunately, ID Tech uses “errorCode” for responses and not just true errors.  It can be very
/// confusing, and there is little consistency on when and how its used. Best to check both if not sure.
/// \param emvData EMV Swipe data in object IDTEMVData.
///
/// \param error Int32 containing Error / Response codes
///
- (void)emvTransactionData:(IDTEMVData * _Null_unspecified)emvData errorCode:(int32_t)error;
/// <em>deviceDisconnected</em>
/// The IDTech callback triggered by disconnectBT.
/// The ConnectionMode indicator in DeviceController is updated to reflect the latest status.
- (void)deviceDisconnected;
@end


#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif
