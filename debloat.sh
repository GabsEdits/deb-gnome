# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./auto.sh" 2>&1
  exit 1
fi
# START
nala remove aisleriot five-or-more four-in-a-row gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles quadrapassel gnome-chess lghtsoff  gnome-robots gnome-sudoku swell-foop gnome-tetravex
