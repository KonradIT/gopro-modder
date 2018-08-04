![](gp-patcher.jpg)

## Patches available:

- Remove Fusion phone restrinction
- Permanently show offline button regardless of internet connection

## Todo:

- Remove "introducing_quik_message1"
- Make camera chooser launcher activity
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

Tested on GoPro app com.gopro.smarty v4.5.2
