#!/usr/bin/zsh
# Easily wake up browser with own profile.

# Firefox use -profile instead of -P profile
typeset -gi fx_path_mode=1

#Like a chromium
chrstyle() {
  dir="$1"
  shift
  print $dir
  "${${modify_browsers[$browser]}:-$browser}" --user-data-dir="${dir}" "$@"
}

#Like a Firefox
fxstyle() {
  profile="$1"
  shift
  if (( fx_path_mode == 1 ))
  then
    "${${modify_browsers[$browser]}:-$browser}" --profile "${profile}" "$@"
  else
    "${${modify_browsers[$browser]}:-$browser}" -P "${profile}" "$@"
  fi
}

#Midori
mdr() {
  typeset browser="midori"
  config="$1"
  shift
  "${${modify_browsers[midori]}:-$browser}" -c "${config}" "$@"
}

#Qupzilla
qup() {
  typeset browser="qupzilla"
  #Qupzilla is not support profile path, so use symlink instead.
  profile="$1"
  shift

  if [[ ! -e "$HOME/.config/qupzilla/profiles/$pfk" ]]
  then
    ln -s "$profile" "$HOME/.config/qupzilla/profiles/${pfk//\//-}"
  elif [[ -h "$HOME/.config/qupzilla/profiles/$pfk" ]]
  then
    rm "$HOME/.config/qupzilla/profiles/${pfk//\//-}"
    ln -s "$profile" "$HOME/.config/qupzilla/profiles/${pfk//\//-}"
  else
    notify-send -r -i browser -u low -a "MyBrowser Chooser" "Can't link qupzilla profile" "Qupzilla profile ${pfk//\//-} is not under control by My Browser Chooser."
  fi

  "${${modify_browsers[qupzilla]}:-$browser}" -p "${pfk//\//-}" "$@"
}

#Rekonq
rek() {
  typeset browser="rekonq"
  config="$1"
  shift
  "${${modify_browsers[rekonq]}:-$browser}" --config "${config}" "$@"
}


#Chromium
chr() {
  typeset -g browser='chromium'
  chrstyle "$@"
}

#Google Chrome
gch() {
  typeset -g browser='google-chrome'
  chrstyle "$@"
}

#SRWare Iron
sri() {
  typeset -g browser='iron'
  chrstyle "$@"
}

#Opera Developer
opdev() {
  typeset -g browser='opera-developer'
  chrstyle "$@"
}

#Opera Beta
opbeta() {
  typeset -g browser='opera-beta'
  chrstyle "$@"
}

#Opera
op() {
  typeset -g browser='opera'
  chrstyle "$@"
}

#Vivaldi
viv() {
  typeset -g browser='vivaldi'
  chrstyle "$@"
}


#Slimjet
slimjet() {
  typeset -g browser='flashpeak-slimjet'
  chrstyle "$@"
}


#firefox
fx() {
  typeset -g browser="firefox"
  fxstyle "$@"
}

#Waterfox
wfx() {
  typeset -g browser="waterfox"
  fxstyle "$@"
}

#Palemoon
pmoon() {
  typeset -g browser="palemoon"
  fxstyle "$@"
}

#SeaMonkey
smb() {
  typeset -g browser="seamonkey"
  fxstyle "$@"
}

typeset -A mybrowsers
typeset -A modify_browsers

# Load config file.
# Plase Define Assoc $mybrowsers like;
# mybrowsers[amazon]='gch ~/.browsers/amazon'
# If you want to modify application command like google-chrome to google-chrome-stable, set like:
# modify_browsers[google-chrome]=google-chrome-stable
. ~/.yek/browserprofilerc

# $1 as a key.
typeset -g pfk="$1"
shift

if [[ -z "${mybrowsers[$pfk]}" ]]
then
  notify-send -i browser -u low -a "MyBrowser Chooser" "No Profile" "Browsr Profile name not given or no such profile($pfk)."
  exit 1
fi

"${=mybrowsers[$pfk]}" "$@"
