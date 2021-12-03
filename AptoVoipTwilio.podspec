#
# Be sure to run `pod lib lint AptoVoipTwilio.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AptoVoipTwilio"
  s.version          = "0.1.0"
  s.summary          = "The Apto external voip features wrapper."
  s.description      = <<-DESC
                          The Apto wrapper to provide external voip features based on Twilio provider.
                       DESC
  s.homepage         = "https://github.com/AptoPayments/apto-voip-twilio-ios-provider"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { "Apto Payments" => "mobile@aptopayments.com" }
  s.source           = { :git => "https://github.com/AptoPayments/apto-voip-twilio-ios-provider.git", :tag => "0.1.0" }

  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.module_name = 'AptoVoipTwilio'
  s.source_files = ['Pod/Classes/wrappers/twilio-voip/**/*.swift']
  s.resources = ["Pod/Classes/wrappers/twilio-voip/CHANGELOG.md"]

  s.frameworks = 'UIKit', 'Foundation', 'CallKit'
  s.dependency 'AptoSDK', '3.8.0'
  s.dependency 'TwilioVoice', '~> 5.0.0'
end
