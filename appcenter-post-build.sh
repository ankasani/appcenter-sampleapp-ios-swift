#!/usr/bin/env bash

#xcodebuild -sdk iphonesimulator -workspace $APPCENTER_SOURCE_DIRECTORY/sampleapp-ios-swift.xcodeproj/project.xcworkspace -scheme sampleapp-ios-swift test -destination "platform=iOS Simulator,name=iPhone 6"

bash <(curl -s https://codecov.io/bash) -t 4fea6cba-071e-4832-8c6f-7fe7ee4bf768
