# My Browser Profile Chooser.
Easy to switch each browser with each profile.

# Usage

```
web <profile_name> [*arg]
web
```

If profile name is not given, this script asks witch profile to use with Zenity dialog,
and also if `-` is given as profile name.

# Configuration

## Config file

Define functions on `$XDG_CONFIG_HOME/reasonset/browserprofiles.yaml`.

for example:

```yaml
---
Profiles:
  fooprofile:
    pstr: /profile.1
    opts:
      - "--incognito"
      - "--proxy-server=socks5://foobar:666"
      - "--password-store=gnome"
    type: chi
Profiles:
  foofxprofile:
    pstr: fooprofile
    opts:
      - "--private-window"
      - "--headless"
    type: fx
Override:
  gch: google-chrome
PathBase: /home/jrh/browser
```

### Profiles

Each profile has name as key and settings as value.

|key in settings|mean|
|-------|---------------------------|
|`pstr`|Profile string. Chromium style browser wants profile directory path, and Firefox style browser wants profile name.|
|`opts`|Command line options array.|
|`env`|A hash. Overriding environment variables.|
|`type`|Browser type. This value is required.|

If `pstr` is not given, use profile name isntead of its value.

Avilable types are:

|name of type|appname|as command|Alias|
|-----|--------|-----------------|-----------|
|`fx`|Mozilla Firefox|`firefox`|`firefox`|
|`fxbeta`|Mozilla Firefox|`firefox-beta`||
|`fxdev`|Mozilla Firefox|`firefox-developer-edition`||
|`wfx`|Waterfox|`faterfox`||
|`pmoon`|Palemoon|`palemoon`|`pmoon`, `palemoon`|
|`smk`|Seamonkey|`seamonkey`||
|`flk`|Falkon|`falkon`|`falkon`|
|`ch`|Chromium|`chromium`|`chromium`, `chr`, `chi`|
|`chdev`|Chromium|`chromium-developer`||
|`gch`|Google Chrome|`google-chrome-stable`|`chrome`|
|`gchbeta`|Google Chrome|`google-chrome-beta`||
|`gchdev`|Google Chrome|`google-chrome-dev`||
|`op`|Opera|`opera`|`opera`|
|`opbeta`|Opera Beta|`opera-beta`||
|`opdev`|Opera Developer|`opera-developer`||
|`viv`|Vivaldi|`vivaldi-stalbe`|`vivaldi`|
|`vivsnap`|Vivaldi Snapshot|`vivaldi-snapshot`||
|`br`|Brave|`brave`|`brave`|
|`sj`|Flashpeak Slimjet|`slimjet`|`slimjet`|
|`ott`|Otter Browser|`otter-browser`|`otter`|
|`epp`|GNOME Epiphany|`epiphany`|`epiphany`|
|`myb`|mybrowse|`mybrowse`|`mybrwose`|
|`lfx1`|Logical Firefox style for override|`firefox`||
|`lfx2`|Logical Firefox style for override|`firefox`||
|`lfx3`|Logical Firefox style for override|`firefox`||
|`lch1`|Logical Chromium style for override|`chromium`||
|`lch2`|Logical Chromium style for override|`chromium`||
|`lch3`|Logical Chromium style for override|`chromium`||

Falkon takes profile name not a profile directory.
You cannot specify profile directory path.

Otter Browser takes profile direcory.

### Override

Override browser command.

Key is a name of type, value is overriding command string.

### PathBase

Profile directory prefix on `pstr` means profile path.

If ommitted, use `${XDG_CONFIG_DIR}:-${HOME}/.config}/reasonset/browsers` instead.

# Important changes

## Profile paramater

Change profile key name `opt` to `opts`

## Defunct supports

Qupzilla is renamed to Falkon.

Midori losts configuration directory option.

SRWare Iron for Linux is discontinued.

Maxthon web browser is discontinued.

Rekonq is discontinued.

## Uncompatibility

*Version 3.x is not compartible to 1.x or 2.x!!*

