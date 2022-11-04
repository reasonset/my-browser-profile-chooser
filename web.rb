#!/usr/bin/ruby
require 'yaml'

class BrowserChooser

  STYLES = {
    fx: ->(profile, env, bin, arg, conf) {
      exec(env, bin, "-P", profile, *arg)
    },

    chr: ->(profile, env, bin, arg, conf) {
      profile = File.join(conf[:profile_dir], profile)
      exec(env, bin, "--user-data-dir=#{profile}", *arg)
    },

    epp: ->(profile, env, bin, arg, conf) {
      profile = File.join(conf[:profile_dir], profile)
      exec(env, bin, "--profile=#{profile}", *arg)
    },

    flk: ->(profile, env, bin, arg, conf) {
      exec(env, bin, "-p", profile, *arg)
    },

    myb: ->(profile, env, bin, arg, conf) {
      profile = File.join(conf[:profile_dir], profile)
      exec(env, bin, "--basedir=#{profile}", *arg)
    },
  }

  BROWSERS = {
    "fx" => {bin: "firefox", proc: STYLES[:fx]},
    "fxdev" => {bin: "firefox-developer-edition", proc: STYLES[:fx]},
    "wfx" => {bin: "waterfox", proc: STYLES[:fx]},
    "pm" => {bin: "palemoon", proc: STYLES[:fx]},
    "smk" => {bin: "weamonkey", proc: STYLES[:fx]},
    "flk" => {bin: "falkon", proc: STYLES[:flk]},
    "ch" => {bin: "chromium", proc: STYLES[:chr]},
    "chdev" => {bin: "chromium-developer", proc: STYLES[:chr]},
    "gch" => {bin: "google-chrome-stable", proc: STYLES[:chr]},
    "gchbeta" => {bin: "google-chrome-beta", proc: STYLES[:chr]},
    "gchdev" => {bin: "google-chrome-developer", proc: STYLES[:chr]},
    "op" => {bin: "opera", proc: STYLES[:chr]},
    "opbeta" => {bin: "opera-beta", proc: STYLES[:chr]},
    "opdev" => {bin: "opera-developer", proc: STYLES[:chr]},
    "viv" => {bin: "vivaldi-stable", proc: STYLES[:chr]},
    "vivsnap" => {bin: "vivaldi-snapshot", proc: STYLES[:chr]},
    "br" => {bin: "brave", proc: STYLES[:chr]},
    "sj" => {bin: "flashpeak-slimjet", proc: STYLES[:chr]},
    "ott" => {bin: "otter-browser", proc: STYLES[:epp]},
    "epp" => {bin: "epiphany", proc: STYLES[:epp]},
    "myb" => {bin: "mybrowse", proc: STYLES[:myb]}
    "lfx1" => {bin: "firefox", proc: STYLES[:fx]},
    "lfx2" => {bin: "firefox", proc: STYLES[:fx]},
    "lfx3" => {bin: "firefox", proc: STYLES[:fx]},
    "lch1" => {bin: "chromium", proc: STYLES[:chr]},
    "lch2" => {bin: "chromium", proc: STYLES[:chr]},
    "lch3" => {bin: "chromium", proc: STYLES[:chr]}
  }

  BROWSERS["firefox"] = BROWSERS["fx"]
  BROWSERS["seamonkey"] = BROWSERS["smk"]
  BROWSERS["pmoon"] = BROWSERS["pm"]
  BROWSERS["palemoon"] = BROWSERS["pm"]
  BROWSERS["falkon"] = BROWSERS["flk"]
  BROWSERS["chi"] = BROWSERS["ch"]
  BROWSERS["chr"] = BROWSERS["ch"]
  BROWSERS["chromium"] = BROWSERS["ch"]
  BROWSERS["chrome"] = BROWSERS["gch"]
  BROWSERS["opera"] = BROWSERS["op"]
  BROWSERS["vivaldi"] = BROWSERS["viv"]
  BROWSERS["brave"] = BROWSERS["br"]
  BROWSERS["epiphany"] = BROWSERS["epp"]
  BROWSERS["slimjet"] = BROWSERS["sj"]
  BROWSERS["otter"] = BROWSERS["ott"]
  BROWSERS["mybrowse"] = BROWSERS["myb"]

  # Ask your profile if not given.
  def profile_dialog
    selected_profile = nil
    IO.popen(["zenity", "--list", "--title=Select Browser Profile", "--width=400", "--height=500", "--column=Profile", *@profiles.keys], "r") do |io|
      selected_profile = io.read
    end
    profile = selected_profile&.strip
    if ! @profiles[profile] || @profiles[profile] == "-"
      profile = (@config["Default"] && @profiles[@config["Default"]]) or exit 0
    end

    @specified_profile = profile
  end

  def initialize
    load_config

    # Update web browser binary path.
    @browsers = BROWSERS.clone
    @config["Override"]&.each do |k, v|
      @browsers[k] && @browsers[k][:bin] = v
    end

    # regist each profile.
    (@profiles = @config["Profiles"]) or err "No Profiles found."
    @profiles.each do |k, profile|
      unless profile["type"] && BROWSERS[profile["type"]]
        err "Profile #{k} is wrong."
      end
    end

    @config[:profile_dir] = @config["PathBase"] || "#{ENV["XDG_CONFIG_HOME"] || "#{ENV["HOME"]}/.config}"}/reasonset/browsers"

    # set profile
    @specified_profile = ARGV.shift

    invoke_browser
  end

  def load_config
    @config = YAML.load(File.read("#{ENV["HOME"]}/.config/reasonset/browserprofiles.yaml")) rescue err("config file not found or parse error.")
    unless Hash === @config
      err "Your config is not a Hash."
    end
  end

  def invoke_browser
    if !@specified_profile || @specified_profile == "-"
      profile_dialog
    end
    
    unless @profiles[@specified_profile]
      err "Profile #{@specified_profile} is not exist."
    end

    unless @browsers[@profiles[@specified_profile]["type"]]
      err "Type #{@browsers[@profiles[@specified_profile]["type"]]} is not defined."
    end

    fork do
      params = @profiles[@specified_profile]
      arg = ARGV
      if params["opts"]
        arg = params["opts"] + ARGV
      end
      @browsers[params["type"]][:proc].call(
        (params["pstr"] || @specified_profile),
        (params["env"] || {}),
        @browsers[params["type"]][:bin],
        arg,
        @config)
    end
  end
  
  private
  
  def err(msg)
    if STDERR.isatty
      abort msg
    else
      system("notify-send", "--icon=browser", "--expire-time=5000", msg)
      exit false
    end
  end
end


BrowserChooser.new
