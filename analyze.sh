#!/bin/bash
xcodebuild -workspace SwiftyHUD.xcworkspace -scheme SwiftyHUD > xcodebuild.log
swiftlint analyze --compiler-log-path xcodebuild.log