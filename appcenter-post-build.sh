#!/usr/bin/env bash

#xcodebuild -sdk iphonesimulator -workspace $APPCENTER_SOURCE_DIRECTORY/sampleapp-ios-swift.xcodeproj/project.xcworkspace -scheme sampleapp-ios-swift test -destination "platform=iOS Simulator,name=iPhone 6"

#bash <(curl -s https://codecov.io/bash) -t 4fea6cba-071e-4832-8c6f-7fe7ee4bf768

#set -ex

#echo App Scheme : $APPCENTER_XCODE_SCHEME

#echo "Scheme: "$APPCENTER_XCODE_SCHEME

#cp $APPCENTER_SOURCE_DIRECTORY/../output/build/archive/sampleapp-ios-swift.xcarchive/BCSymbolMaps/*bcsymbolmap $APPCENTER_OUTPUT_DIRECTORY

# Post Build Script

echo App Build Variant : $APPCENTER_XCODE_PROJECT
echo App Scheme : $APPCENTER_XCODE_SCHEME
echo 
if [ "$APPCENTER_XCODE_SCHEME" == "CalabashProd" ];then

echo "**************************************************************************************************"
echo "Post Build Script"
echo "**************************************************************************************************"

##################################################
# Start UI Tests
##################################################

# variables
appCenterLoginApiToken=$AppCenterLoginForAutomatedUITests # this comes from the build environment variables
appName="Infogroup/Salesgenie-iOS"
deviceSetName="Infogroup/ios-device-set1-c41e2b"
testSeriesName="master"

echo ""
echo "Start Xamarin.UITest run"
echo App Build Variant : $APPCENTER_XCODE_PROJECT
echo App Name : $appName
echo Device Set : $deviceSetName
echo Test Series : $testSeriesName
echo ""

UITestProject=`find "$APPCENTER_SOURCE_DIRECTORY" -name Salesgenie_UITest.csproj`

UITestVersionNumber=`grep '[0-9]' $UITestProject | grep Xamarin.UITest|grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,10\}\-'dev`
echo UITestPrereleaseVersionNumber: $UITestVersionNumber

UITestVersionNumberSize=${#UITestVersionNumber}
echo UITestVersionNumberSize: $UITestVersionNumberSize

    if [ $UITestVersionNumberSize == 0 ]
    then
        UITestVersionNumber=`grep '[0-9]' $UITestProject | grep Xamarin.UITest|grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
        echo UITestVersionNumber: $UITestVersionNumber
    fi

TestCloudExe=`find ~/.nuget | grep test-cloud.exe | grep $UITestVersionNumber | head -1`
echo TestCloudExe: $TestCloudExe

TestCloudExeDirectory=`dirname $TestCloudExe`
echo TestCloudExeDirectory: $TestCloudExeDirectory

npm install -g appcenter-cli

appcenter login --token a87fb910ff43519b9fd26dae3e6e79f88a7825af

echo ">>>>>> Run UI test command >>>>>>"
# Note: must put a space after each parameter/value pair
appcenter test run uitest --app $appName --devices $deviceSetName --app-path $APPCENTER_OUTPUT_DIRECTORY/Salesgenie.apk --test-series $testSeriesName --locale "en_US" --build-dir $APPCENTER_SOURCE_DIRECTORY/Salesgenie_Automation/Salesgenie_UITest/bin/Debug --uitest-tools-dir $TestCloudExeDirectory --include $APPCENTER_SOURCE_DIRECTORY/Salesgenie_Automation/Salesgenie_UITest/bin/Debug/Salesgenie_UITest.dll.config --async

echo "**************************************************************************************************"
echo "Post Build Script complete"
echo "**************************************************************************************************"
fi
