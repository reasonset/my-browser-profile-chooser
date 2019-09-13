#!/usr/bin/ruby
require 'yaml'

class BrowserChooser

  FXSTYLE = ->(profile, env, bin, arg, conf) {
    exec(env, bin, "-P", profile, *arg)
  }

  CHRSTYLE = ->(profile, env, bin, arg, conf) {
    if conf["PathBase"]
      profile = conf["PathBase"] + profile
    end
    p arg
    exec(env, bin, "--user-data-dir=#{profile}", *arg)
  }

  BROWSERS = {
    "fx" => {bin: "firefox", proc: FXSTYLE},
    "wfx" => {bin: "waterfox", proc: FXSTYLE},
    "pmoon" => {bin: "palemoon", proc: FXSTYLE},
    "smk" => {bin: "weamonkey", proc: FXSTYLE},
    "flk" => {bin: "falkon", proc: ->(profile, env, bin, arg, conf) { exec(env, bin, "-p", profile, *arg) } },
    "chi" => {bin: "chromium", proc: CHRSTYLE},
    "gch" => {bin: "google-chrome-stable", proc: CHRSTYLE},
    "op" => {bin: "opera", proc: CHRSTYLE},
    "opbeta" => {bin: "opera-beta", proc: CHRSTYLE},
    "opdev" => {bin: "opera-developer", proc: CHRSTYLE},
    "viv" => {bin: "vivaldi-stable", proc: CHRSTYLE},
    "vivsnap" => {bin: "vivaldi-snapshot", proc: CHRSTYLE},
    "slimjet" => {bin: "flashpeak-slimjet", proc: CHRSTYLE}
  }

  # Ask your profile if not given.
  def profile_dialog
    selected_profile = nil
    IO.popen(["zenity", "--list", "--title=Select Browser Profile", "--width=400", "--height=500", "--column=Profile", *@profiles.keys], "r") do |io|
      selected_profile = io.read
    end
    profile = selected_profile&.strip
    unless @profiles[profile]
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
      unless profile["type"] && BROWSERS[profile["type"]] && profile["pstr"]
        err "Profile #{k} is wrong."
      end
    end

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
    unless @specified_profile
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
      if params["opt"]
        arg = params["opt"] + ARGV
      end
      @browsers[params["type"]][:proc].call(params["pstr"], (params["env"] || {}), @browsers[params["type"]][:bin], arg, @config)
    end
  end
  
  private
  
  def err(msg)
    if STDERR.isatty
      abort msg
    else
      system("notify-send", "--icon=browser", "--expire-time=5000", msg)
    end
  end
end


BrowserChooser.new
