# My Browser Profile Chooser.

Easy to switch each browser with each profile.

# Usage

```
web <profile_name> [*arg]
web - [*arg]
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
    pstr: profile.1
    opts:
      - "--incognito"
      - "--proxy-server=socks5://foobar:666"
      - "--password-store=gnome"
    type: chi
  foofxprofile:
    pstr: fooprofile
    opts:
      - "--private-window"
      - "--headless"
    type: fx
Override:
  gch: google-chrome
PathBase: /home/jrh/browser
Dialog: kdialog
```

### Profiles

Each profile has name as key and settings as value.

|key in settings|mean|
|-------|---------------------------|
|`pstr`|Profile string. Chromium style browser wants profile directory path, and Firefox style browser wants profile name.|
|`opts`|Command line options array.|
|`env`|A hash. Overriding environment variables.|
|`type`|Browser type. This value is required.|
|`url`|String append to `opts`. Weaver (Fossil) requires this.|

If `pstr` is not given, use profile name isntead of its value.

Avilable types are:

|name of type|appname|as command|Alias|
|-----|--------|-----------------|-----------|
|`fx`|Mozilla Firefox|`firefox`|`firefox`|
|`fxbeta`|Mozilla Firefox|`firefox-beta`||
|`fxdev`|Mozilla Firefox|`firefox-developer-edition`||
|`wfx`|Waterfox|`faterfox`||
|`pm`|Palemoon|`palemoon`|`pmoon`, `palemoon`|
|`smk`|Seamonkey|`seamonkey`||
|`wolf`|librewolf|`librewolf`||
|`cachy`|Cachy-browser|`cachy-browser`||
|`ict`|GNU IceCat|`icecat`|`icecat`|
|`flp`|Floorp Browser|`floorp`||
|`mdr`|Mirodi|`midori`|`midori`|
|`flk`|Falkon|`falkon`|`falkon`|
|`ch`|Chromium|`chromium`|`chromium`, `chr`, `chi`|
|`chdev`|Chromium|`chromium-developer`||
|`gch`|Google Chrome|`google-chrome-stable`|`chrome`|
|`gchbeta`|Google Chrome (Beta)|`google-chrome-beta`||
|`gchdev`|Google Chrome (Dev)|`google-chrome-dev`||
|`op`|Opera|`opera`|`opera`|
|`opbeta`|Opera Beta|`opera-beta`||
|`opdev`|Opera Developer|`opera-developer`||
|`viv`|Vivaldi|`vivaldi-stalbe`|`vivaldi-stable`|
|`vivsnap`|Vivaldi Snapshot|`vivaldi-snapshot`||
|`edg`|Microsoft Edge|`microsoft-edge-stable`|`edge`|
|`edgbeta`|Microsoft Edge Beta|`microsoft-edge-beta`||
|`edgdev`|Microsoft Edge Dev|`microsoft-edge-dev`||
|`br`|Brave|`brave`|`brave`|
|`sj`|Flashpeak Slimjet|`slimjet`|`slimjet`|
|`sri`|SRware Iron|`srware-iron`|`iron`, `srware`|
|`ott`|Otter Browser|`otter-browser`|`otter`|
|`epp`|GNOME Epiphany|`epiphany`|`epiphany`|
|`myb`|mybrowse|`mybrowse`|`mybrwose`|
|`wvf`|Weaver (Fossil)|`weaver`|`weaver`|
|`lfx1`|Logical Firefox style for override|`firefox`||
|`lfx2`|Logical Firefox style for override|`firefox`||
|`lfx3`|Logical Firefox style for override|`firefox`||
|`lfx4`|Logical Firefox style for override|`firefox`||
|`lfx5`|Logical Firefox style for override|`firefox`||
|`lch1`|Logical Chromium style for override|`chromium`||
|`lch2`|Logical Chromium style for override|`chromium`||
|`lch3`|Logical Chromium style for override|`chromium`||
|`lch4`|Logical Chromium style for override|`chromium`||
|`lch5`|Logical Chromium style for override|`chromium`||

Falkon takes profile name not a profile directory.
You cannot specify profile directory path.

Otter Browser takes profile direcory.

### Override

Override browser command.

Key is a name of type, value is overriding command string.

For example, Google Chrome `gch` invokes `google-chrome-stable` command,
but if Google Chrome is installed as `google-chrome` to your environment, set

```yaml
Override:
  gch: google-chrome
```

### PathBase

Profile directory prefix on `pstr` means profile path.

If ommitted, use `${XDG_CONFIG_DIR}:-${HOME}/.config}/reasonset/browsers` instead.

### Dialog

What dialog to use for selecting profile.

You can choice `yad`, `kdialog`, `rofi`, `dmenu`, `bemenu` or else.
`zenity` is used by default.

`dmenu` or `bemenu` refers `menu_monitor` configuration.

# Important changes

## Profile paramater

Change profile key name `opt` to `opts`

## Defunct supports

* Qupzilla is renamed to Falkon.
* Midori losts configuration directory option. (Chromium based version)
* Maxthon web browser is discontinued.
* Rekonq is discontinued.

## Uncompatibility

*Version 3.x is not compartible to 1.x or 2.x!!*

## Default path base

Before version 3.3, `PathBase` is not set.

Since version 3.3, `${XDG_CONFIG_DIR}:-${HOME}/.config}/reasonset/browsers` for `PathBase` by default.
It may change in future.
