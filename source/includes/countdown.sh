#!/bin/bash

###################################################################
# Script Author: Djordje Jocic                                    #
# Script Year: 2018                                               #
# Script License: MIT License (MIT)                               #
# =============================================================== #
# Personal Website: http://www.djordjejocic.com/                  #
# =============================================================== #
# Permission is hereby granted, free of charge, to any person     #
# obtaining a copy of this software and associated documentation  #
# files (the "Software"), to deal in the Software without         #
# restriction, including without limitation the rights to use,    #
# copy, modify, merge, publish, distribute, sublicense, and/or    #
# sell copies of the Software, and to permit persons to whom the  #
# Software is furnished to do so, subject to the following        #
# conditions.                                                     #
# --------------------------------------------------------------- #
# The above copyright notice and this permission notice shall be  #
# included in all copies or substantial portions of the Software. #
# --------------------------------------------------------------- #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, #
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND        #
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT     #
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,    #
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, RISING     #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR   #
# OTHER DEALINGS IN THE SOFTWARE.                                 #
###################################################################

#################
# GET FUNCTIONS #
#################

# GET FUNCTIONS GO HERE

#################
# SET FUNCTIONS #
#################

# GET FUNCTIONS GO HERE

##################
# CORE FUNCTIONS #
##################

# Creates a countdown based on the provided parameters.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2018 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $countdown_time
#   Countdown time that should be used, ex. <i>10s</i> or <i>15s,10s</i>.
# @param integer $countdown_delay
#   Countdown delay that should be used, ex. <i>10</i> for a 10s delay.
# @param string $countdown_message
#   Countdown message that should be used, ex. <i>renew the cert</i>.
# @param string $countdown_effect
#   Sound effect that should be used for an countdown.
# @param integer $countdown_volume
#   Master volume (percentage) that should be used during playback.
# @param string $countdown_command
#   Command that should be executed when an countdown is triggered.
# @param string $countdown_global
#   Flag <i>yes</i> if countdown should be triggered globally, and vice versa.
# @param string $countdown_display
#   Countdown display that should be used for displaying alarm message.
# @return void

create_countdown()
{
    # Core Variables
    
    local countdown_time="$1";
    local countdown_delay="$2";
    local countdown_message="$3";
    local countdown_effect="$4";
    local countdown_volume="$5";
    local countdown_command="$6";
    local countdown_global="$7";
    local countdown_display="$8";
    
    # Step 1 -Print Notice
    
    if [ -n "$countdown_delay" ]; then
        printf "Starting a %s countdown, after a %s second delay...\n\n" "$countdown_time" "$countdown_delay";
    else
        printf "Starting a %s countdown...\n\n" "$countdown_time";
    fi
    
    if [ -n "$countdown_message" ]; then
        printf "Following message will be shown: %s\n\n" "$countdown_message";
    fi
    
    # Step 2 - Initialize Countdown
    
    if [ -n "$countdown_delay" ]; then
        sleep_for "Delay" "${countdown_delay}s";
    fi
    
    sleep_for "Countdown" "$countdown_time";
    
    # Step 3 - Trigger Alarm
    
    play_sound_effect "$countdown_effect" "$countdown_volume" "$countdown_global" &
    
    if [ -n "$countdown_message" ]; then
        show_alarm_message "$countdown_message" "$countdown_global" "$countdown_display" &
    fi
    
    if [ -n "$countdown_command" ]; then
        execute_alarm_command "$countdown_command" "$countdown_global" &
    fi
}

###################
# CHECK FUNCTIONS #
###################

# CHECK FUNCTIONS GO HERE

###################
# OTHER FUNCTIONS #
###################

# Resolves a provided sound effect ID and prints the path toward it.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2018 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $effect_dir
#   Directory containing effects.
# @param string $effect_id
#   ID of a sound effect that should be resolved.
# @return void

print_countdown_effect_path()
{
    # Core Variables
    
    local effect_dir="$1";
    local effect_id="$2";
    
    # Logic
    
    case "$effect_id" in
        
        "")
            echo "$effect_dir/fire-alarm.wav";
        ;;
        
        "1")
            echo "$effect_dir/fire-alarm.wav";
        ;;
        
        "2")
            echo "$effect_dir/analogue-watch.wav";
        ;;
        
        "3")
            echo "$effect_dir/annoying-alarm.wav";
        ;;
        
        "4")
            echo "$effect_dir/missile-alert.wav";
        ;;
        
        "5")
            echo "$effect_dir/tornado-siren.wav";
        ;;
        
    esac
}
