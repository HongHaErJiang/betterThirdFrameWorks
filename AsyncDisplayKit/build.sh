#!/bin/bash

# **** Update me when new Xcode versions are released! ****
PLATFORM="platform=iOS Simulator,OS=9.3,name=iPhone 6"
SDK="iphonesimulator9.3"


# It is pitch black.
set -e
function trap_handler() {
    echo -e "\n\nOh no! You walked directly into the slavering fangs of a lurking grue!"
    echo "**** You have died ****"
    exit 255
}
trap trap_handler INT TERM EXIT


MODE="$1"

if type xcpretty-travis-formatter &> /dev/null; then
    FORMATTER="-f $(xcpretty-travis-formatter)"
  else
    FORMATTER="-s"
fi

if [ "$MODE" = "tests" ]; then
    echo "Building & testing AsyncDisplayKit."
    pod install
    set -o pipefail && xcodebuild \
        -workspace AsyncDisplayKit.xcworkspace \
        -scheme AsyncDisplayKit \
        -sdk "$SDK" \
        -destination "$PLATFORM" \
        build test | xcpretty $FORMATTER
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "examples" ]; then
    echo "Verifying that all AsyncDisplayKit examples compile."
    #Update cocoapods repo
    pod repo update master

    for example in examples/*/; do
        echo "Building (examples) $example."

        if [ -f "${example}/Podfile" ]; then
          echo "Using CocoaPods"
          if [ -f "${example}/Podfile.lock" ]; then
              rm "$example/Podfile.lock"
          fi
          rm -rf "$example/Pods"
          pod install --project-directory=$example
          
          set -o pipefail && xcodebuild \
              -workspace "${example}/Sample.xcworkspace" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              -derivedDataPath ~/ \
              build | xcpretty $FORMATTER
        elif [ -f "${example}/Cartfile" ]; then
          echo "Using Carthage"
          local_repo=`pwd`
          current_branch=`git rev-parse --abbrev-ref HEAD`
          cd $example
          
          echo "git \"file://${local_repo}\" \"${current_branch}\"" > "Cartfile"
          carthage update --platform iOS
          
          set -o pipefail && xcodebuild \
              -project "Sample.xcodeproj" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              build | xcpretty $FORMATTER
          
          cd ../..
        fi
    done
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "examples-pt1" ]; then
    echo "Verifying that all AsyncDisplayKit examples compile."
    #Update cocoapods repo
    pod repo update master

    for example in $((find ./examples -type d -maxdepth 1 \( ! -iname ".*" \)) | head -6 | head); do
        echo "Building (examples-pt1) $example."

        if [ -f "${example}/Podfile" ]; then
          echo "Using CocoaPods"
          if [ -f "${example}/Podfile.lock" ]; then
              rm "$example/Podfile.lock"
          fi
          rm -rf "$example/Pods"
          pod install --project-directory=$example
          
          set -o pipefail && xcodebuild \
              -workspace "${example}/Sample.xcworkspace" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              -derivedDataPath ~/ \
              build | xcpretty $FORMATTER
        elif [ -f "${example}/Cartfile" ]; then
          echo "Using Carthage"
          local_repo=`pwd`
          current_branch=`git rev-parse --abbrev-ref HEAD`
          cd $example
          
          echo "git \"file://${local_repo}\" \"${current_branch}\"" > "Cartfile"
          carthage update --platform iOS
          
          set -o pipefail && xcodebuild \
              -project "Sample.xcodeproj" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              build | xcpretty $FORMATTER
          
          cd ../..
        fi
    done
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "examples-pt2" ]; then
    echo "Verifying that all AsyncDisplayKit examples compile."
    #Update cocoapods repo
    pod repo update master

    for example in $((find ./examples -type d -maxdepth 1 \( ! -iname ".*" \)) | head -12 | tail -6 | head); do
        echo "Building $example (examples-pt2)."

        if [ -f "${example}/Podfile" ]; then
          echo "Using CocoaPods"
          if [ -f "${example}/Podfile.lock" ]; then
              rm "$example/Podfile.lock"
          fi
          rm -rf "$example/Pods"
          pod install --project-directory=$example
          
          set -o pipefail && xcodebuild \
              -workspace "${example}/Sample.xcworkspace" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              -derivedDataPath ~/ \
              build | xcpretty $FORMATTER
        elif [ -f "${example}/Cartfile" ]; then
          echo "Using Carthage"
          local_repo=`pwd`
          current_branch=`git rev-parse --abbrev-ref HEAD`
          cd $example
          
          echo "git \"file://${local_repo}\" \"${current_branch}\"" > "Cartfile"
          carthage update --platform iOS
          
          set -o pipefail && xcodebuild \
              -project "Sample.xcodeproj" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              build | xcpretty $FORMATTER
          
          cd ../..
        fi
    done
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "examples-pt3" ]; then
    echo "Verifying that all AsyncDisplayKit examples compile."
    #Update cocoapods repo
    pod repo update master

    for example in $((find ./examples -type d -maxdepth 1 \( ! -iname ".*" \)) | head -7 | head); do
        echo "Building $example (examples-pt3)."

        if [ -f "${example}/Podfile" ]; then
          echo "Using CocoaPods"
          if [ -f "${example}/Podfile.lock" ]; then
              rm "$example/Podfile.lock"
          fi
          rm -rf "$example/Pods"
          pod install --project-directory=$example
          
          set -o pipefail && xcodebuild \
              -workspace "${example}/Sample.xcworkspace" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              -derivedDataPath ~/ \
              build | xcpretty $FORMATTER
        elif [ -f "${example}/Cartfile" ]; then
          echo "Using Carthage"
          local_repo=`pwd`
          current_branch=`git rev-parse --abbrev-ref HEAD`
          cd $example
          
          echo "git \"file://${local_repo}\" \"${current_branch}\"" > "Cartfile"
          carthage update --platform iOS
          
          set -o pipefail && xcodebuild \
              -project "Sample.xcodeproj" \
              -scheme Sample \
              -sdk "$SDK" \
              -destination "$PLATFORM" \
              build | xcpretty $FORMATTER
          
          cd ../..
        fi
    done
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "life-without-cocoapods" ]; then
    echo "Verifying that AsyncDisplayKit functions as a static library."

    set -o pipefail && xcodebuild \
        -workspace "smoke-tests/Life Without CocoaPods/Life Without CocoaPods.xcworkspace" \
        -scheme "Life Without CocoaPods" \
        -sdk "$SDK" \
        -destination "$PLATFORM" \
        build | xcpretty $FORMATTER
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "framework" ]; then
    echo "Verifying that AsyncDisplayKit functions as a dynamic framework (for Swift/Carthage users)."

    set -o pipefail && xcodebuild \
        -project "smoke-tests/Framework/Sample.xcodeproj" \
        -scheme Sample \
        -sdk "$SDK" \
        -destination "$PLATFORM" \
        build | xcpretty $FORMATTER
    trap - EXIT
    exit 0
fi

echo "Unrecognised mode '$MODE'."
