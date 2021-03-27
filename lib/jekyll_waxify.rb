# frozen_string_literal: true

require "jekyll_waxify/version"
require "jekyll_waxify/jekyll_config"

module Jekyll
  module Waxify
    WAXIFY_FRAMEWORK = File.join(File.dirname(File.expand_path(__FILE__)),
                                 "../../wax-framework/.")
    JEKYLL_DIR = Dir.pwd
  end
end
