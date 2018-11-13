## GoPro Patcher/Modder
## Proceed with caution!

echo "   _____       _____             __  __           _     _           "
echo "  / ____|     |  __ \           |  \/  |         | |   | |          "
echo " | |  __  ___ | |__) | __ ___   | \  / | ___   __| | __| | ___ _ __ "
echo " | | |_ |/ _ \|  ___/ '__/ _ \  | |\/| |/ _ \ / _  |/ _  |/ _ \ '__|"
echo " | |__| | (_) | |   | | | (_) | | |  | | (_) | (_| | (_| |  __/ |   "
echo "  \_____|\___/|_|   |_|  \___/  |_|  |_|\___/ \__,_|\__,_|\___|_|   "
echo "                                                                    "
echo ""

## Pre flight:
command -v patch >/dev/null 2>&1 || { echo "Patch not installed" >&2; err=1; }
command -v apktool >/dev/null 2>&1 || { echo "Apktool not installed" >&2; err=1; }
if [[ $1 == "" ]]
	then
		echo "main.sh -i [original gopro APK] -k [key] -n [key name] -o [modded apk out]"
		exit 1
fi
while true; do
	case "$1" in
		-h)
		    echo "main.sh -i [original gopro APK] -k [key] -n [key name] -o [modded apk out]"
			exit 1
			break;
		;;
		-i )
			orig_apk="$2"
			shift 2
		;;
		-o )
			out_apk="$2"
			shift 2
		;;
		-k )
			key="$2"
			shift 2
		;;
		-n )
			key_name="$2"
			shift 2
		;;
        * )
			break
		;;
    esac
done

## Steps
function decompile_apk(){
	if [[ $orig_apk != "" ]]
		then
			if [ -d "modded" ]
				then
					echo "Warning: modded directory exists:"
					echo -ne "Delete directory + decompile APK or use directory? [delete/keep]: "
					read dirchoice
					if [[ $dirchoice == "delete" ]]
						then
						rm -r modded/
						apktool d $orig_apk -o modded/
					fi
				else
					apktool d $orig_apk -o modded/
			fi
	else
		echo ">> Original APK not specified, run script again with -i flag"
	fi

}
function apply_patch(){
	APP_VERSION=$(cat modded/apktool.yml | grep versionName: | grep -o "'.*'" | sed "s/'//g")
	COUNT=0
	declare -a arr
	for i in patches/$APP_VERSION/*
		do
		
		echo [$COUNT] - $i
		arr=("${arr[@]}" "$i")	
		((COUNT++))
	done

	echo -ne ">>Select patches [number]: "; read mods_chosen
	if [[ $mods_chosen == "" ]]
		then
			#apply all
			echo ">> Applying all patches"
			for i in patches/$APP_VERSION/*
				do
				echo $i
				if [[ "$i" == *sh ]]
					then
						echo "Executing $i"
						sh $i
					else
						patch -p0 < $i
				fi
			done
		else
			for i in ${mods_chosen[@]}
				do
				selected_patch=${arr[$i]}
				echo ${arr[$i]}
				if [[ "$selected_patch" == *sh ]]
					then
						sh $selected_patch
					else
						patch -p0 < $selected_patch
				fi
			done
			echo -ne "Apply another patch? [y/n]: "
			read applyanother
			if [[ $applyanother == "y" ]]
				then
					apply_patch
			fi
	fi
}

function compile_apk(){
	
	if [[ $out_apk != "" ]]
	then
		apktool b modded/ -o $out_apk
	else
		echo ">> Modified APK name not specified, run script again with -o flag"
	fi
}

function sign_apk(){
	
	if [[ $key != "" ]]
	then
		jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $key $out_apk $key_name
	else
		echo ">> KeyStore filename not specified, run script again with -k flag"
	fi
}
## Main
echo ""
echo ">> Step 1: Decompile APK"
echo ">> Decompiling $orig_apk ..."
echo ""
decompile_apk
echo ""
echo ">> Step 2: Select Patch"
echo ""
apply_patch
echo ""
echo ">> Compile APK"
echo ""
compile_apk
echo ""
echo ">> Sign APK"
echo ""
sign_apk

echo ""
echo "!!!!!!!"
echo "Finished! Install apk now with adb install $out_apk" 
