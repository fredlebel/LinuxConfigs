#! /bin/sh

target=$(bspc query -N -n '.!automatic.local' | head -n 1)

if [ -n "$target" ] ; then
	echo "node=${target}"
else
	echo "state=floating"
fi

