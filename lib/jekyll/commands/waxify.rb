# frozen_string_literal: true

# Add wax components to a Jekyll site
module Jekyll
  # Commands
  module Commands
    # Waxify
    class WaxifyCommand < Command
      def self.init_with_program(prog)
        prog.command(:waxify) do |c|
          c.syntax "waxify [coll]"
          c.description "Add Wax components"

          c.action { |args, options| process(args, options) }
        end
      end

      def self.process(args = [], _options = [])
        coll = args[0]

        jekyll_config = Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, Jekyll::Waxify::JEKYLL_DIR)

        return if jekyll_config.waxified

        jekyll_config.add_cors
        jekyll_config.add_collection(coll)
        jekyll_config.merge
        jekyll_config.save
        jekyll_config.deploy_framework
      end
    end
  end
end
