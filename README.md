# My Browser Profile Chooser.
Easy to switch each browser with each profile.

# Usage

```
web.rb <profile_name> [*arg]
web.rb
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

Is `pstr` is not given, use profile name isntead of its value.

Avilable types are:

|name of type|appname|as command|
|-----|--------|-----------------|
|`fx`|Mozilla Firefox|`firefox`|
|`wfx`|Waterfox|`faterfox`|
|`pmoon`|Palemoon|`palemoon`|
|`smk`|Seamonkey|`seamonkey`|
|`flk`|Falkon|`falkon`|
|`falkon`|Falkon|`falkon`|
|`ch`|Chromium|`chromium`|
|`chi`|Chromium|`chromium`|
|`chr`|Chromium|`chromium`|
|`gch`|Google Chrome|`google-chrome-stable`|
|`chrome`|Google Chrome|`google-chrome-stable`|
|`op`|Opera|`opera`|
|`opera`|Opera|`opera`|
|`opbeta`|Opera Beta|`opera-beta`|
|`opdev`|Opera Developer|`opera-developer`|
|`viv`|Vivaldi|`vivaldi-stalbe`|
|`vivaldi`|Vivaldi|`vivaldi-stalbe`|
|`vivsnap`|Vivaldi Snapshot|`vivaldi-snapshot`|
|`slimjet`|Flashpeak Slimjet|`slimjet`|
|`otter`|Otter Browser|`otter-browser`|
|`lfx1`|Logical Firefox style for override|`firefox`|
|`lfx2`|Logical Firefox style for override|`firefox`|
|`lfx3`|Logical Firefox style for override|`firefox`|
|`lch1`|Logical Chromium style for override|`chromium`|
|`lch2`|Logical Chromium style for override|`chromium`|
|`lch3`|Logical Chromium style for override|`chromium`|


Falkon takes profile name not a profile directory.
You cannot specify profile directory path.

Otter Browser takes profile direcory.

### Override

Override browser command.

Key is a name of type, value is overriding command string.

### PathBase

Profile directory prefix on `pstr` means profile path.

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

