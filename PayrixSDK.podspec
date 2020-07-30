#――― Start of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

Pod::Spec.new do |s|

  s.name         = "PayrixSDK"
  s.version      = "2.0.1"
  s.summary      = "PayrixSDK for licensed customers only. Version 2.0.1 adds support for Swift 5"

  #

  s.homepage     = "https://payrix.com/home/"

  #

  s.author               = "Payrix"

  #

  s.platform     = :ios
  s.ios.deployment_target = '12.0'

  #

  s.source       = { :git => "https://github.com/payrix/Payrix_SDK_iOS", :tag => s.version }
  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "PayrixSDK/PayCore.framework", "PayrixSDK/PayCard.framework"

  # ――― End of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

end
