#!/bin/bash

# Example: Change bundle name of an iOS app for non-production
if [ '$APPCENTER_BRANCH' == 'dev1' ]
then
    plutil -replace CFBundleName -string "WEC.Translation.Client.Dev" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
    plutil -replace CFBundleDisplayName -string "WEC Translator Dev" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
    plutil -replace CFBundleIdentifier -string "com.Westinghouse.WEC.Translation.Client.Dev" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
elif [ '$APPCENTER_BRANCH' == 'test1' ]
then
	plutil -replace CFBundleName -string "WEC.Translation.Client.Test" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
	plutil -replace CFBundleDisplayName -string "WEC Translator Test" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
	plutil -replace CFBundleIdentifier -string "com.Westinghouse.WEC.Translation.Client.Test" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
elif [ '$APPCENTER_BRANCH' == 'master' ]
then
		plutil -replace CFBundleName -string "WEC.Translation.Client" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
		plutil -replace CFBundleDisplayName -string "WEC Translator" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
		plutil -replace CFBundleIdentifier -string "com.Westinghouse.WEC.Translation.Client" $APPCENTER_SOURCE_DIRECTORY/WEC.Translation.Client/WEC.Translation.Client.iOS/Info.plist
fi
