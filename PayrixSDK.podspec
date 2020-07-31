#――― Start of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

Pod::Spec.new do |s|

  s.name         = "PayrixSDK"
  s.version      = "2.1.0"
  s.summary      = "PayrixSDK for licensed customers only. Version 2.1.0 supports for Swift 5 and provides a Demo app."

  #

  s.homepage     = "https://payrix.com/home/"

  #

  s.author               = "Payrix"

  #

  s.platform     = :ios
  s.ios.deployment_target = '12.0'

  # Updated on 7-30-2020 to move repo from GitLab to GitHub for CocoaPods.

  s.source       = { :git => "https://github.com/payrix/Payrix_SDK_iOS", :tag => s.version }
  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "PayrixSDK/PayCore.framework", "PayrixSDK/PayCard.framework"

  # ――― End of PodSpec for PayrixSDK ―――――――――――――――――――――――――――――――――――――――――― #

end
