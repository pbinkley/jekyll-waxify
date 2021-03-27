# frozen_string_literal: true

require "yaml"
require "jekyll"
require "byebug"

# Add wax components to a Jekyll site
module Jekyll
  # Commands
  module Commands
    # Waxify
    class WaxifyCommand < Command
      class << self
        def init_with_program(prog)
          prog.command(:waxify) do |c|
            c.syntax "waxify [coll]"
            c.description "Add Wax components"

            c.action { |args, options| process(args, options) }
          end
        end

        def process(args = [])
          coll = args[0]

          jekyll_config = Waxify::JekyllConfig.new(WAXIFY_FRAMEWORK, JEKYLL_DIR)

          return if config.waxified

          jekyll_config.add_cors
          jekyll_config.add_collection(coll)
          jekyll_config.merge
          jekyll_config.save
          jekyll_config.deploy_framework
        end
      end
    end
  end
end
