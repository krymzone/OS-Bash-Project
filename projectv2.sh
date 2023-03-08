#!/bin/bash

show_menu(){
    normal=`echo "\033[m"` #White text
    menu=`echo "\033[36m"` #Blue
    number=`echo "\033[33m"` #Yellow
    bgred=`echo "\033[41m"` #Bright red
    fgred=`echo "\033[31m"` #Red
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Convert numbers to different bases${normal}\n"
    printf "${menu}**${number} 2)${menu} Compile and run a C program ${normal}\n"
    printf "${menu}**${number} 3)${menu} Text tools ${normal}\n"
    printf "${menu}**${number} 4)${menu} Show system info and export it to a text file ${normal}\n"
    printf "${menu}**${number} 5)${menu} Install/Update dependencies for our script ${fgred}(needs user password)${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please insert a menu option and press enter or ${fgred}x to exit. ${normal}"
    read opt
}

option_picked(){ #This shows the option that has been picked 
    msgcolor=`echo "\033[01;31m"` # bold red
    normal=`echo "\033[00;00m"` # normal white
    message=${@:-"${normal}Error: No message passed"}
    printf "${msgcolor}${message}${normal}\n"
}

clear
show_menu
while [ $opt != '' ]
    do
    if [ $opt = '' ]; then
      exit;
    else
      case $opt in
        1) clear;
show_menu3(){ #Shows the "Conversion" sub-menu 
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Convert decimal number to binary code ${normal}\n"
    printf "${menu}**${number} 2)${menu} Convert binary code to Gray ${normal}\n"
    printf "${menu}**${number} 3)${menu} Why not both? ${normal}\n"
    printf "${menu}**${number} 4)${menu} Convert decimal number to any base ${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please insert a menu option and press enter or ${fgred}x to go back to the main menu. ${normal}"
    read opt3
}
clear
show_menu3
while [ $opt3 != '' ]
    do
    if [ $opt3 = '' ]; then
      exit;
    else
      case $opt3 in
        1) clear;
            option_picked "You've chosen option 1 : Convert number from decimal to binary ";
            printf "${menu}Enter any decimal number to be converted to binary:  ${normal}";
            read n
            c=$(echo "obase=2;$n" | bc) #Basic Calculator is used to switch from base 10 to base 2. You can change it to any base you want by modifying "obase=..."
            printf "The binary form of the chosen number is: ${fgred}$c ${normal}\n";
            show_menu3;
        ;;
        2) clear;
            option_picked "You've chosen option 2 : Convert number from binary to Gray ";
            printf "${menu}Enter any binary number to be converted to Gray:  ${normal}";
            read -r n #-r is used to prevent blackslashes being used as an escape characher
            typeset -i g=0 #Declares variable for g(gray), -i is used to mark the var as having an int value
            typeset -i i=0
            typeset -i c="$n"
            while (( c != 0 ))
            do
                a=$(( c%10 ))
                c=$(( c/10 ))
                b=$(( c%10 ))
                if (( ( a & !b )  || ( !a &  b ) ))#In this type of problem bitwise operators should be used, not logical
                then
                    g=$(echo "$g+10^$i" | bc)
                fi
                ((i++))
            done
            printf "The Gray code of ${fgred}$n ${normal} is ${fgred}$g ${normal}\n";
            show_menu3;
        ;;
        3) clear;
            option_picked "You've chosen option 3 : Both"; #Option 3 is mainly just a combination of Option 1 and 2, it's basically the same code
            printf "${menu}Choose any decimal number: ${normal}";
            read -r n
            n=$(echo "obase=2;$n" | bc)
            typeset -i g=0
            typeset -i i=0
            typeset -i c="$n"
            while (( c != 0 ))
            do
                a=$(( c%10 ))
                c=$(( c/10 ))
                b=$(( c%10 ))
                if (( ( a & !b )  || ( !a &  b ) ))
                then
                    g=$(echo "$g+10^$i" | bc)
                fi
                ((i++))
            done
            printf "The binary code of the chosen number is: ${fgred}$n ${normal} and the Gray code is: ${fgred}$g ${normal}\n";
            show_menu3;
        ;;
        4) clear;
            option_picked "You've chosen option 4 : Convert decimal number to any base";
            printf "${menu}Enter any decimal number to be converted:  ${normal}";
            read n
            printf "${menu}Choose a base: ${normal}";
            read base
            c=$(echo "obase=$base;$n" | bc) #Basic Calculator is used to switch from base 10 to base 2
            printf "The base $base form of the chosen number is: ${fgred}$c ${normal}\n";
            show_menu3;
        ;;
        x) clear;
           show_menu;
           break;#break is used to break out of the if loop
        ;;
        *)clear; #any other option will prompt you to pick a valid one
            option_picked "Pick an option from the menu";
            show_menu3;
        ;;
      esac
    fi
done
        ;;
        2) clear;
show_menu2(){ #shows the C compiler sub-menu
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Check GCC version ${normal}\n"
    printf "${menu}**${number} 2)${menu} Update GCC ${fgred}(needs user password)${normal}\n"
    printf "${menu}**${number} 3)${menu} Just compile and run a C program? ${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please insert a menu option and press enter or ${fgred}x to go back to the main menu. ${normal}"
    read opt2
}
clear
show_menu2
while [ $opt2 != '' ]
    do
    if [ $opt2 = '' ]; then
      exit;
    else
      case $opt2 in
        1) clear;
            option_picked "You've chosen option 1 : Check GCC version ";
            gcc --version #--version can be used alongside any program if you want to check the version
            show_menu2;
        ;;
        2) clear;
            option_picked "You've chosen option 2 : Update GCC ";
            sudo apt-get install gcc #"install" can also be used to update programs, is a lot quicker than "update", but it only updates 1 program.
            printf "GCC has been updated to the latest version";
            show_menu2;
        ;;
        3) clear;
            option_picked "You've chosen option 3 : Just compile and run a C program ";
            printf "${menu}Please enter the directory of the file: \nNote: If your file is in the same directory as the script just press ${fgred}enter\n"${normal};
            ls -d */ #lists only directories, if used without "*/" it will only show "."
            read dir #input the name of the directory
            gcc -o program $(find $dir -name *.c) #Use GNU Compiler Collection(gcc) to compile a file called "program" (it will create a temporary file), then runs it "find" is used to find the file itself
            ./program # runs the compiled program
            rm program # deletes the program, since it's not needed anymore
            echo
            show_menu2;
        ;;
        x)clear;
          show_menu;
          break;#breaks out of the if loop
        ;;
        *)clear; #any other option will prompt you to pick a valid one
            option_picked "Pick an option from the menu";
            show_menu2;
        ;;
      esac
    fi
done
        ;;
        3) clear;
            option_picked "You've chosen option 3 : Text tools";
show_menu4(){ #shows the Text tools sub-menu
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Find a word ${normal}\n"
    printf "${menu}**${number} 2)${menu} Replace a word ${normal}\n"
    printf "${menu}**${number} 3)${menu} Merge multiple text files ${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please insert a menu option and press enter or ${fgred}x to go back to the main menu. ${normal}"
    read opt4
}
clear
show_menu4
while [ $opt4 != '' ]
    do
    if [ $opt4 = '' ]; then
      exit;
    else
      case $opt4 in
        1) clear;
            option_picked "You've chosen option 1 : Find a word ";
            printf "${menu}Directories in current directory:\n"${normal};
            ls -d */ #shows only directories
            printf "${menu}Please choose a directory...\n${normal}";
            read dir
            if [[ -e "$dir" && -d "$dir" ]]; #checks if the directory specified exists and if it is a directory
            then
            read -p "Word to search for: " word
            echo
            inst=`grep -rwo "$dir" -e "$word" | wc -l` #counts the number of instances
            if [[ "$inst" != 0 ]]; #if instances = 0
            then
            grep --color=always -rnw "$dir" -e "$word"
            printf "$inst number of instances have been found";
            else
            printf "The word $word has not been found"
            fi
            else
            printf "The directory "$dir" does not exit";
            fi
            show_menu4;
        ;;
        2) clear;
            option_picked "You've chosen option 2 : Replace a word ";
echo -e "${menu}**********************\nFiles in current directory:\n`ls -p | grep --color=always -v /`\n**********************${normal}"
		read -p "File name: " FILE
                clear
		#if the file exists
		if [[ -e "$FILE" ]]; then
			echo -e "${menu}**********************\nContents of file "$FILE": \n********************** ${normal}"
			#show the contents of the file
			cat "$FILE"
			read -rep $'\n**********************\nWord to search for: ' WORD
			#see if the file has the word
                        clear
			INS=`grep -wo "$WORD" "$FILE" | wc -l`
			#if we can find a word enter the loop
			if [[ "$INS" != 0 ]]; then
				#show the amount of appearances
				echo -e "${menu}**********************\nFound ${fgred}"$INS" ${menu}instances of the word ${fgred}"$WORD" \n**********************${normal}";
				#present all the found words
				grep --color=always -wno "$WORD" "$FILE" | nl 
				read -rep $'\nWhich one would you like to replace? ${fgred}(1, 2, ... , all): ' REPLY2
				#if we get a correct response
				if [[ "$REPLY2" == *[1-"$INS"] || "$REPLY2" == "all" ]]; then
					read -rep $'**********************\nWord to replace it with: ' WORD2
					#if response is a number
					if [[ "$REPLY2" == *[1-"$INS"] ]]; then
						sed -zi "s/"$WORD"/"$fgred""$WORD2""$normal"/"$REPLY2"" "$FILE"
					fi
					#if response is all
					if [[ "$REPLY2" == "all" ]]; then
						sed -i "s/"$WORD"/"$fgred""$WORD2""$normal"/" "$FILE"
					fi
					echo -e "${menu}**********************\nSuccessfully replaced, contents of file\n**********************\n${normal}"
				else
					echo -e "${menu}**********************\nOutside of range \n**********************\n${normal}"
				fi
			else
				printf "${menu}The word ${fgred}"$WORD" ${menu}hasn't been found${normal}"
			fi
		else
			echo -e "${menu}**********************\n${fgred}"$FILE" ${menu}does not exist \n**********************\n${normal}"
		fi
            show_menu4;
        ;;
        3) clear;
            option_picked "You've chosen option 3 : Merge multiple text files ";
            printf "${menu}Directories in current directory:\n"${normal};
            ls -d */ #shows only directories
            printf "\n${menu}Please enter the directory of the files you want to merge.\n${number}Note: It will only merge ${fgred}.txt ${number}files\n"${normal};
            read dir
            if [[ -e "$dir" && -d "$dir" ]]; #checks if the directory exists and if it is a directory
            then
            echo #it's only purpose is to add a blank space
            printf "How would you like to name the output file ?\n";
            read out #input the name if the file outputed
            echo
            cat $dir/*.txt > $out #Get every file in a certain directory, use cat to merge them and output as a file named afer $out
            printf "$out has been created successfully!\n";
            else
            printf "Directory specified does not exist";
            fi
            show_menu4;
        ;;
        x)clear;
          show_menu;
          break;
        ;;
        *)clear; #any other option will prompt you to pick a valid one
            option_picked "Pick an option from the menu";
            show_menu4;
        ;;
      esac
    fi
done
        ;;
        4) clear;
            option_picked "You've chosen option 4 : Show system info and export it to a text file ";
            printf "${menu}Please choose a name for your file:\n${normal}";
            read name #Output name of the file
            echo #blank space (I'm just too lazy to write \n)
            neofetch --stdout | tee $name.txt #"--stdout" is used in order to disable neofetch's visuals, since it can break things."tee" outputs stdout to both the terminal and a file
            printf "$name has been been succesfully exported\n";
            show_menu;
        ;;
        5) clear;
            option_picked "Installing dependencies...";
            sudo apt-get install bc #installs/updates Basic Calculator, used mostly in the Conversion submenu
            sudo apt-get install gcc #installs/updates GNU Compiler Collection, used mostly in the C compiler submenu
            sudo apt-get install neofetch #installs/updates Neofetch, used to output system info
            printf "\n${fgred}Script dependencies have been successfully installes/updated${normal}";
            show_menu;
	;;
        x)exit;
        ;;
        *)clear; #any other option will prompt you to pick a valid one
            option_picked "Pick an option from the menu";
            show_menu;
        ;;
      esac
    fi
done