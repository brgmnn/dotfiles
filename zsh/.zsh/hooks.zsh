preexec() {
    export ZSH_CMD_TIME_START=`date +%s.%3N`
}

precmd() {
    vcs_info

    environment=`readlink .env`

    if [[ $? -eq 0 ]]; then
        environment=`echo -n $environment | cut -c6-`

        if [[ "$environment" == "engineering" ]]; then
            export ZSH_DOTENV_ENVIRONMENT="%F{7}(%f%F{yellow}engr%f%F{7})%f"
        elif [[ "$environment" == "production" ]]; then
            export ZSH_DOTENV_ENVIRONMENT="%K{red}%F{15} PROD %f%k"
        else
            export ZSH_DOTENV_ENVIRONMENT="%F{7}(%f%F{blue}${environment}%f%F{7})%f"
        fi
    else
        unset ZSH_DOTENV_ENVIRONMENT
    fi

    if (( ${+ZSH_CMD_TIME_START} )); then
        NOW=`date +%s.%3N`
        # let "elapsed = ${NOW} - ${ZSH_CMD_TIME_START} + 3*24*60*60 + 13*60*60 + 6*60 + 10"
        # let "elapsed = ${NOW} - ${ZSH_CMD_TIME_START} + 13*60*60 + 6*60 + 10"
        # let "elapsed = ${NOW} - ${ZSH_CMD_TIME_START} + 43*60 + 10"
        # let "elapsed = ${NOW} - ${ZSH_CMD_TIME_START} + 13"

        let "elapsed = ${NOW} - ${ZSH_CMD_TIME_START}"

        green=$(tput setaf 2)
        cyan=$(tput setaf 6)
        yellow=$(tput bold; tput setaf 3)
        red=$(tput bold; tput setaf 1)
        normal=$(tput sgr0)

        if (( $elapsed >= 4 && $elapsed < 60 )); then
            printf "\nElapsed time: ${cyan}%.3f${normal} seconds\n", $elapsed
        elif (( $elapsed >= 60 && $elapsed < 60*60 )); then
            let "minutes = floor(${elapsed} / 60)"
            let "seconds = ${elapsed} - 60 * ${minutes}"

            printf "\nElapsed time: ${green}%.f${normal} minutes, ${cyan}%.1f${normal} seconds\n", $minutes $seconds
        elif (( $elapsed >= 60*60 && $elapsed < 24*60*60 )); then
            let "hours = floor(${elapsed} / (60*60))"
            let "minutes = floor((${elapsed} - 60*60*${hours}) / 60)"
            let "seconds = ${elapsed} - 60*60*${hours} - 60*${minutes}"

            printf "\nElapsed time: ${yellow}%.f${normal} hours, ${green}%.f${normal} minutes, ${cyan}%.f${normal} seconds\n", $hours $minutes $seconds
        elif (( $elapsed >= 24*60*60 )); then
            let "days = floor(${elapsed} / (24*60*60))"
            let "hours = floor((${elapsed} - 24*60*60*${days}) / (60*60))"
            let "minutes = floor((${elapsed} - 24*60*60*${days} - 60*60*${hours}) / 60)"
            let "seconds = ${elapsed} - 24*60*60*${days} - 60*60*${hours} - 60*${minutes}"

            printf "\nElapsed time: ${red}%.f${normal} days, ${yellow}%.f${normal} hours, ${green}%.f${normal} minutes, ${cyan}%.f${normal} seconds\n", $days $hours $minutes $seconds
        fi
    fi

    unset ZSH_CMD_TIME_START
}
