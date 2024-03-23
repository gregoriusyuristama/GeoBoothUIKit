#!/bin/sh

#  ci_pre_xcodebuild.sh
#  GeoBoothUIKit
#
#  Created by Gregorius Yuristama Nugraha on 3/23/24.
#  

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_PRIMARY_REPOSITORY_PATH/ci_scripts || exit 1

# Create the plist content
PLIST_CONTENT="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>SUPABASE_URL</key>
    <string>$SUPABASE_URL</string>
    <key>SUPABASE_API_KEY</key>
    <string>$SUPABASE_API_KEY</string>
    <key>SUPABASE_ROOT_API_KEY</key>
    <string>$SUPABASE_ROOT_API_KEY</string>
</dict>
</plist>"

# Write a JSON File containing all the environment variables and secrets.
echo "${PLIST_CONTENT}" > ../GeoBoothUIKIT/Core/Utilities/Supabase/Supabase-Secret.plist

echo "Wrote Supabase-Secrets.plist file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
