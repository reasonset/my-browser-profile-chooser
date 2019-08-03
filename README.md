# My Browser Profile Chooser.
Easy to switch each browser with each profile.

# Usage

```
$ web <profile_name>
```

# Configuration

## Config file

Define functions on `$XDG_CONFIG_HOME/reasonset/browserprofilerc.zsh`.
Each profile function name should begin with `webpf_`.
like:

```zsh
webpf_sample() {
	profile="$HOME/profiles/sample" # Profile name or path.
	fx
}
```

If you want edit or add command-line arguments,
use `$cliarg` array paramater.

```zsh
webpf_sample() {
	cliarg=(--incognito "$cliarg[@]")
	profile="$HOME/profiles/sample" # Profile name or path.
	chi
}
```

`$profile` is a profile name or path.
It's a directory if it is chromium style argument,
or it's a name if it is Falkon's argument.

Firefox use path to profile directory by default.
If you want to use Firefox profile name, you can set

```zsh
(( fx_path_mode=0 ))
```

in your config file.

## Avail shorthands

Finally, call one of these commands on last of your profile function.

* `fx` (Firefox)
* `wfx` (Waterfox)
* `pmoon` (Plaemoon)
* `smk` (Seamonkey)
* `flk` (Falkon)
* `chi` (Chromium)
* `gch` (Google Chrome)
* `op` (Opera)
* `opbeta` (Opera Beta)
* `opdev` (Opera Developer)
* `viv` (Vivaldi)
* `vivbeta` (Vivaldi Beta)
* `vivsnap` (Vivaldi snapshot)
* `slimjet` (Flashpeak Slimjet)

If you want call custom command with firefox style command-line option,
you can call `fxstyle` with `browser` paramater as a command.
Also you can call with chromium style command-line option, you can use `chrstyle`.

## Actually called commands

You can override with aliasing.

* `firefox`
* `waterfox`
* `palemoon`
* `seamonkey`
* `falkon`
* `chromium`
* `google-chrome-stable`
* `opera`
* `opera-beta`
* `opera-developer`
* `vivaldi-stable`
* `vivaldi-beta`
* `vivaldi-snapshot`
* `flashpeak-slimjet`

# Important changes

## Defunct supports

Qupzilla is renamed to Falkon.

Midori losts configuration directory option.

SRWare Iron for Linux is discontinued.

Maxthon web browser is discontinued.

Rekonq is discontinued.

## Uncompatibility

*Version 2.x is not compartible to 1.x!!*

