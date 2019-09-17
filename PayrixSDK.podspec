#――― Start of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

Pod::Spec.new do |s|

  s.name         = "PayrixSDK"
  s.version      = "1.1.0"
  s.summary      = "PayrixSDK for licensed customers only. Version 1.1.0 adds support for ID Tech Readers"

  #

  s.homepage     = "https://payrix.com/home/"

  #

  s.author               = "Payrix"

  #

  s.platform     = :ios
  s.ios.deployment_target = '12.0'

  #

  s.source       = { :git => "https://gitlab.com/payrix/mobile/payrix_mobile_sdk.git", :tag => s.version }
  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "PayrixSDK/PayCore.framework", "PayrixSDK/PayCard.framework"

  # ――― End of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

end
