Pod::Spec.new do |s|
  s.name         = "SwiftyHUD"
  s.version      = "0.1"
  s.summary      = "HUD Wrapper for your custom view"
  s.description  = <<-EOS
  SwiftyHUD allow you to customize your View and use it as a HUD
  EOS
  s.homepage     = "https://github.com/embassem/SwiftyHUD"
  s.license      = { :type => "MIT", :file => "License.md" }
  s.author             = { "Bassem" => "embassem@gmail.com" }
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  s.source       = { :git => "https://github.com/embassem/SwiftyHUD.git", :tag => s.version }
  s.default_subspec = "Core"
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'  

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/Core/"
    ss.framework  = "Foundation","UIKit"
  end

  s.subspec "NVActivityIndicator" do |ss|
    ss.source_files = "Sources/ReactiveMoya/"
    ss.dependency "SwiftyHUD/Core"
    ss.dependency "NVActivityIndicatorView", "~> 4.8"
  end

  s.subspec "lottie" do |ss|
    ss.source_files = "Sources/RxMoya/"
    ss.dependency "SwiftyHUD/Core"
    ss.dependency "lottie-ios", "~> 3.1.6"
  end
end
