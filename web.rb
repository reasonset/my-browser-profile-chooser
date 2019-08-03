#!/usr/bin/ruby
require 'yaml'

class BrowserChooser
# プロファイルが指定されていない場合に利用する
def profile_dialog
  selected_profile = nil
  IO.popen(["zenity"], "r") do |io|
    selected_profile = io.read
  end
  profile = selected_profile.strip
  unless @profiles["Profile"][profile]
    profile = @profiles["Default"] or exit 0
  end

  @specified_profile = profile
end

  def initialize
    load_config
    @browser_progs = BROWSERS.dup
    if @profiles["Override"]
      @browser_progs.merge! @profiles["Override"]
    end

    invoke_browser
  end

  def load_config
    @profiles = YAML.load(File.read("#{ENV["HOME"]}/.config/reasonset/browserprofiles.yaml"))
  end

  def invoke_browser
    unless @specified_profile
      profile_dialog
    end

    fork do
      params = @profiles["Profile"][@specified_profile]
      if params["env"]
        params["env"].each do |k, v|
          ENV[k] = v.to_s
        end
      end

    end
  end
end
