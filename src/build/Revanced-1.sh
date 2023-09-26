#!/bin/bash
# Revanced build
source ./src/build/utils.sh

#################################################

# Checking new patch
checker "revanced/revanced-patches" "revanced"

#################################################

# Download requirements
dl_gh "revanced-patches" "revanced" "v2.191.0-dev.9"
dl_gh "revanced-cli" "revanced" "latest"
dl_gh "revanced-integrations" "revanced" "v0.118.0-dev.9"
#################################################

# Patch YouTube:
get_patches_key "youtube-revanced"
get_ver "Video ads" "com.google.android.youtube"
get_apk "youtube" "youtube" "google-inc/youtube/youtube"
patch "youtube" "revanced"

#################################################

# Patch YouTube Music:
# Arm64-v8a
get_patches_key "youtube-music-revanced"
get_apk "youtube-music-arm64-v8a" "youtube-music" "google-inc/youtube-music/youtube-music" "arm64-v8a"
patch "youtube-music-arm64-v8a" "revanced"
# Armeabi-v7a
get_patches_key "youtube-music-revanced"
get_apk "youtube-music-armeabi-v7a" "youtube-music" "google-inc/youtube-music/youtube-music" "armeabi-v7a"
patch "youtube-music-armeabi-v7a" "revanced"

#################################################

# Split architecture:
rm -f revanced-cli* revanced-patches*.jar patches.json 
dl_gh "revanced-cli" "j-hc" "latest"
dl_gh "revanced-patches" "revanced" "latest"
# Split architecture Youtube:
for i in {0..3}; do
    split_arch "youtube-revanced" "youtube-${archs[i]}-revanced" "$(gen_rip_libs ${libs[i]})"
done

#################################################
