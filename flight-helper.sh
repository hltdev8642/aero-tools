#!/bin/bash
# name: flight-helper
# auth: hltdev [hltdev8642@gmail.com]
# desc: Flight calculations helper.

#
# source of descriptions: FS ACADEMY IFR [fsacademy.co.uk/ifr]
#

#
# DISTANCE TO HEIGHT => DISTANCE x3
#
# This is probably our most used rule of thumb. It works for long ranges, such
# as when to begin a descent from cruise altitude, or to check your progress
# as you near a beacon. In light aircraft then this rule is basically all you
# need. For larger aircraft with higher inertia, you also have to account for
# the distance it will take to reduce speed. In most practical terms, this
# means ‘adding a bit’, such as 5-10nm, to your distance.
#
# Example: 15nm to landing. 15x3=45. Target altitude 4500ft.
#

    function d2h ()
    {
        if [[ -z $1 ]]; then
            echo "distance to runway (nm):"
            read distance_to_runway
        else
            distance_to_runway="$1"
        fi

        multfactor="300"

        target_altitude=$(($distance_to_runway * $multfactor ))

        echo "Target altitude is: ${target_altitude} ft"

    }


#
# 3 DEGREE DESCENT => GROUNDSPEED x5
#
# Easily worked out and highly useful, the Groundspeed x5 rule works at long or
# short ranges. If we had a strong tailwind on approach and did not adjust for
# it, we would be covering ground more quickly, so our 1 of descent would
# still take us down in the same amount of time, but as we have travelled
# further in that time, we might have overshot the airport! Basing our rule
# on groundspeed solves this problem and takes account of any head or
# tailwind.
#
# Example: Speed 100kts 100x5= 500fpm.
#


    function deg2dec ()
    {
         if [[ -z $1 ]]; then
            echo "Groundspeed (kts):"
            read groundspeed
        else
            groundspeed="$1"
        fi

        multfactor="5"

        descent_rate=$(($groundspeed * $multfactor ))

        echo "Target descent rate is: ${descent_rate} fpm"

    }


#
# RATE 1 TURN => 10% AIRSPEED +7
#
# All IFR turns are made at rate 1, which is 3 degrees per second. At Rate 1
# you will turn 180 in 1min and a 360 in 2mins. By adding 7 to 10% of your
# airspeed, you roughly work out the bank angle needed to achieve rate 1.
# You are assisted by the turn co-ordinator, which indicates rate 1 turns
# when a wing is touching a ‘block’ on the dial.
#
# Example: Speed 120kts. 12+7= 19 degrees bank.
#
# For larger aircraft, which go through significant speed changes throughout a
# flight, you will be calculating for a few different speeds. If your answer
# comes up at more than 25 degrees of bank, disregard your calculation and just
# use 25 degrees, as this is considered the maximum bank angle for flying
# procedures. In the cruise, rate 1 turns are a little excessive for passenger
# comfort, so make your turns earlier and with more like 10 degrees bank when
# cruising in an airliner.



function rate1turn ()
{
     if [[ -z $1 ]]; then
        echo "Speed (kts):"
        read speed
    else
        speed="$1"
    fi

    addfactor="7"
    # 10_percent="10"
    # speed_adjust=$(($speed / $10_percent))
    bank_rate=$(($speed / 10 + $addfactor ))

    echo "Target bank rate is: ${bank_rate} degrees bank"

}

#
# TURN ANTICIPATION => 1% GROUNDSPEED
#
#
# Most useful when a large turn is required, using 1% of your groundspeed is best
# suited with medium-large aircraft. Throughout the scenarios you will fly, try
# to calculate when to turn, but remember that this will be very conservative
# unless a very large change of direction is required.
#
# Example: Speed 200kts Begin turn with 2nm remaining
#
function turn_anti ()
{
     if [[ -z $1 ]]; then
        echo "Speed (kts):"
        read speed
    else
        speed="$1"
    fi

   	divfactor="100"
    turn_dist=$(($speed / $divfactor ))

    echo "Begin turn with ${turn_dist} nm remaining"

}


#
# LEVEL OFF => 10% VERTICAL SPEED
#
#
# Most useful when a large turn is required, using 1% of your groundspeed is best
# suited with medium-large aircraft. Throughout the scenarios you will fly, try
# to calculate when to turn, but remember that this will be very conservative
# unless a very large change of direction is required.
#

#
# LEVEL OFF => 10% VERTICAL SPEED
#
#
# Example: Climbing at 700fpm. Begin to lower the nose with 70ft remaining.
#
# Be aware that ICAO stipulate some restrictions on vertical speed.
# In European airspace, if there is traffic nearby as you reach your desired
# altitude, they impose a limit of 1500fpm for the last 1000ft of climb.
# The UK have slightly different rules, where you are to reduce your vertical
# speed to 1500fpm earlier, for the last 1500ft of climb. They also impose a
# minimum rate of 500fpm in controlled airspace. The FAA impose different rules
# again, so for maximum realism, look into the restrictions in place for where
# you intend to fly.
#
# There are more of these quick calculations out there, but we are covering the
# important ones for our purposes. They all get easier with practice.
#

function level_off ()
{
     if [[ -z $1 ]]; then
        echo "Climb rate (fpm):"
        read speed
    else
        speed="$1"
    fi

   	divfactor="10"
    leveloff_dist=$(($speed / $divfactor ))

    echo "Begin to lower the nose with ${leveloff_dist} ft remaining"

}

#
# show help text (echo)
#
function show_help ()
{
    echo "OPTIONS:"
    echo ""
    echo "  DISTANCE TO HEIGHT => DISTANCE x3"
    echo "  >>> d2h [args]"
    echo ""
    echo "  3 DEGREE DESCENT => GROUNDSPEED x5"
    echo "  >>> deg2dec [args]"
    echo ""
    echo "  RATE 1 TURN => 10% AIRSPEED +7"
    echo "  >>> rate1turn [args]"
    echo ""
    echo "  TURN ANTICIPATION => 1% GROUNDSPEED"
    echo "  >>> turn_anti [args]"
    echo ""
    echo "  LEVEL OFF => 10% VERTICAL SPEED"
    echo "  >>> level_off [args]"
    echo ""

}

#
# program entry point
#
function main ()
{

        if [[ -z "${@:1}" ]]; then
            show_help
            exit
        else
            case "$1" in
                h|help|?|-h|-help|-?|--help)
                    show_help
                    exit
                ;;

                *)
                    "$@"
                ;;
            esac
        fi
}

# main "$@"
. flight-helper.sh && exit
