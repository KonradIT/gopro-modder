![](gp-patcher.jpg)

## Disclaimer:

Everything here is unsupported by GoPro. Do not ask them for support when using modified app.

I am not affiliated or endorsed by GoPro, Inc. in any way. 

Proceed with caution.

## Patches available:

### 5.0:

- Remove Fusion phone restrinction, which is limited as of now.
- Make Camera Selector the Main Launcher Activity

### 4.5.2:

- Remove Fusion phone restrinction, which is limited as of now.
- Permanently show offline button regardless of internet connection

## Todo:

- Remove "introducing_quik_message1"
- Photo/video downloads to SD card

Submit ideas by making a new issue.

PRs welcome!

## Apply patches:

    ./main.sh -i [original APK] -k [android keystore] -n [alias for android keystore] -o [apk out name]

- [original APK] = stock GoPro APK, extract it from your phone or get it from APKmirror.com (check that the version is compatible!)
- [android keystore] = an Android APK signing key, generate one by running: ````keytool -genkey -v -keystore androidkey.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000````
- [alias for android keystore] = alias defined in android keystore
- [apk out name] = name for output APK, eg: out.apk

## Compatibility:

Tested on GoPro app com.gopro.smarty Versions: v5.0, v4.5.2
