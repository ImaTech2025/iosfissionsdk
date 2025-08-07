Pod::Spec.new do |s|
  s.name = 'FSUnionAdSDK'
  s.version = '1.0.1.50'
  s.summary = 'FSUnionAdSDK is a SDK from LinkSure providing union AD service.'
  s.description = <<-DESC
                  FSUnionAdSDK provides Union ADs which include splash、interstitial、native、banner、feed、rewardVideo etc.
                  DESC
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'https://github.com/ImaTech2025/iosfissionsdk.git'
  s.author = { 'ImaTech2025' => 'IMA-Tech@zenmen.com' }
  s.source = { :git => 'git@github.com:ImaTech2025/iosfissionsdk.git', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5']

  s.vendored_frameworks =  ['FSUnionAdSDK/FSUnionAdSDK.xcframework']
  s.resources = 'FSUnionAdSDK/FSUnionAdSDK.bundle'

  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.weak_frameworks = 'AppTrackingTransparency', 'DeviceCheck'
end
