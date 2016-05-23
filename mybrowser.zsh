#!/usr/bin/zsh
# Easily wake up browser with own profile.

# Firefox use -profile instead of -P profile
typeset -gi fx_path_mode=1

#Like a chromium
chrstyle() {
  dir="$1"
  shift
  "${${modify_browsers[$browser]}:-$browser}" --user-data-dir="$dir" "$@"
}

#Like a Firefox
fxstyle() {
  profile="$1"
  shift
  if (( fx_path_mode == 1 ))
  then
    "${${modify_browsers[$browser]}:-$browser}" -profile "$profile" "$@"
  else
    "${${modify_browsers[$browser]}:-$browser}" -P "$profile" "$@"
  fi
}

#Midori
mdr() {
  config="$1"
  shift
  midori -c "$config" "$@"
}

#Qupzilla
qup() {
  profile="$1"
  shift
  qupzilla -p="$profile" "$@"
}

#Rekonq
rek() {
  config="$1"
  shift
  rekonq --config "$config" "$@"
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
# mybrowsers[amazon]='gch https://www.amazon.com/'
# If you want to modify application command like google-chrome to google-chrome-stable, set like:
# modify_browsers[google-chrome]=google-chrome-stable
. ~/.yek/browserprofilerc

# $1 as a key.
eval "$mybrowsers[$1]"
