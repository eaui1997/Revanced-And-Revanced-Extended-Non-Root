#!/bin/bash
# Revanced Extended for android 6 & 7 build
source src/build/utils.sh

#################################################

# Checking new patch
checker "kitadai31/revanced-patches-android6-7" "revanced-extended-android-6-7"

#################################################

# Download requirements
dl_gh "revanced-patches-android6-7 revanced-integrations" "kitadai31" "latest"
dl_gh "revanced-cli" "revanced" "latest"

#################################################

# Patch YouTube Extended:
get_patches_key "youtube-revanced-extended-6-7"
version="17.34.36"
get_apk "youtube" "youtube" "google-inc/youtube/youtube"
patch "youtube" "revanced-extended-android-6-7"

#################################################

# Split architecture:
rm -f revanced-cli* revanced-patches*.jar patches.json 
dl_gh "revanced-cli" "j-hc" "latest"
dl_gh "revanced-patches" "revanced" "latest"
# Split architecture Youtube:
for i in {0..3}; do
    split_arch "youtube-revanced-extended-android-6-7" "youtube-${archs[i]}-revanced-extended-android-6-7" "$(gen_rip_libs ${libs[i]})"
done

#################################################