#!/bin/bash
git submodule init
git submodule update
time make iframework BUILDTYPE=Release

echo "New framework built to: ./build/ios/pkg/dynamic/Mapbox.framework"
echo "Coping the framework to s3"

# grab the latest version and increment it
directory=s3://indigo-mapbox-distribution/framework/
lastVersion=$(aws s3 ls "$directory" | grep -o indigo-.* | sed 's/[^0-9]//g' | sort -n | tail -1)
nextVersion=$((lastVersion + 1))
version="ios-v5.2.0-alpha.3-indigo-$nextVersion"
echo "Next version", $version
zip -r ./build/ios/pkg/dynamic ./build/ios/pkg
aws s3 cp ./build/ios/pkg/dynamic.zip "$directory$version/build.zip"
echo "Package located at: "
echo "https://indigo-mapbox-distribution.s3.amazonaws.com/framework/$version/build.zip"
echo "Change the s3 url located https://github.com/indigo-ag/react-native-mapbox-gl/blob/develop/scripts/download-mapbox-gl-native-ios.sh"

