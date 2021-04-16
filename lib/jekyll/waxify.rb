# frozen_string_literal: true

require "jekyll/waxify/version"
require "jekyll/waxify/jekyll_config"

module Jekyll
  module Waxify
      WAXIFY_FRAMEWORK = File.join(File.dirname(File.expand_path(__FILE__)),
                                       "../../wax-framework/.")
      JEKYLL_DIR = Dir.pwd
  end
end

require "jekyll/commands/waxify.rb"
