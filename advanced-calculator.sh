#!/bin/bash

MAX_HISTORY_LINES=5
ANS_FILE="ans_value.txt"
HISTORY_FILE="calc_history.txt"


update_history()
{
	local line=$1
	if [ ! -e "$HISTORY_FILE" ]; then
		touch "$HISTORY_FILE"
	fi

	if [ $(wc -l < "$HISTORY_FILE") -ge $MAX_HISTORY_LINES ]; then
		tail -n $((MAX_HISTORY_LINES - 1)) "$HISTORY_FILE" > temp.txt 
		mv temp.txt "$HISTORY_FILE"
	fi

	echo "$line" >> "$HISTORY_FILE"
}

clear_terminal()
{
	clear || tput reset
}

wait_for_user()
{
	read -n 1 -s -r -p ""
	clear_terminal
}

while true; do
	echo -n ">> "
	    read -r -a input_array
    
    if [ ${#input_array[@]} -eq 1 ]; then
        # If only one argument is provided
        if [ "${input_array[0]}" == "EXIT" ]; then
			break
		elif [ "${input_array[0]}" == "HIST" ]; then
			if [ -e "$HISTORY_FILE" ]; then
				cat "$HISTORY_FILE"
				wait_for_user
			else
				echo "No history found"
			fi
		fi
    elif [ ${#input_array[@]} -eq 3 ]; then
        # If three arguments are provided
        num1=${input_array[0]}
        ops=${input_array[1]}
        num2=${input_array[2]}
		# if num1 is ANS then replace it with the value in ANS_FILE
		if [ "$num1" == "ANS" ]; then
			if [ -e "$ANS_FILE" ]; then
				num1=$(cat "$ANS_FILE")
			else
				echo "No previous answer found"
				continue
			fi
		fi
		# if num2 is ANS then replace it with the value in ANS_FILE
		if [ "$num2" == "ANS" ]; then
			if [ -e "$ANS_FILE" ]; then
				num2=$(cat "$ANS_FILE")
			else
				echo "No previous answer found"
				continue
			fi
		fi
		if [[ $num1 =~ ^[0-9]+$ ]] && [[ $num2 =~ ^[0-9]+$ ]]; then
			case $ops in
				"+")
					result=$((num1 + num2))
					echo $result
					echo "$result" > "$ANS_FILE"
					update_history "$num1 $ops $num2 = $result"
					;;
				"-")
					result=$((num1 - num2))
					echo $result
					echo "$result" > "$ANS_FILE"
					update_history "$num1 $ops $num2 = $result"
					;;
				"*")
					result=$((num1 * num2))
					echo $result
					echo "$result" > "$ANS_FILE"
					update_history "$num1 $ops $num2 = $result"
					;;
				"/")
					if [ $num2 -eq 0 ]; then
						echo "MATH ERROR"
					else
						result=$(echo "scale=2; $num1 / $num2" | bc)
						echo $result
						echo "$result" > "$ANS_FILE"
						update_history "$num1 $ops $num2 = $result"
					fi
					;;
				"%")
					if [ $num2 -eq 0 ]; then
						echo "MATH ERROR"
					else
						result=$((num1 % num2))
						echo $result
						echo "$result" > "$ANS_FILE"
						update_history "$num1 $ops $num2 = $result"
					fi
					;;
				*)
					echo " SYNTAX ERROR"
					;;
			esac
			wait_for_user
		else
			echo "Invalid input"
		fi
    fi

done
