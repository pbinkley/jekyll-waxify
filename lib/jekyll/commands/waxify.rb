# frozen_string_literal: true

require "yaml"
require_relative "../waxify/version"

# Add wax components to a Jekyll site
module Jekyll
  # Commands
  module Commands
    # Waxify
    class Waxify < Command
      class << self
        def init_with_program(prog)
          prog.command(:waxify) do |c|
            c.syntax "waxify [coll]"
            c.description "Add Wax components"

            c.action do |args, options|
              coll = args[0]

              config_text = File.read("#{Dir.pwd}/_config.yml")
              config = YAML.safe_load(config_text)

              # CORS stanza and "waxified" flags are added if this is the first run
              unless config["waxified"]
                new_config = {}

                # add framework documents to jekyll
                framework = File.join(
                  File.dirname(File.expand_path(__FILE__)),
                  "../../../wax-framework/."
                )
                FileUtils.cp_r framework, Dir.pwd

                # Add CORS stanza to _config.yml
                unless config.dig("webrick", "header", "Access-Control-Allow-Origin")
                  new_config["webrick"] = {
                    "header" => {
                      "Access-Control-Allow-Origin" => "*"
                    }
                  }
                end

                if coll
                  # Add new collection
                  config_text += "\ncollections:\n" unless config["collections"]

                  # Make coll images dir and metadata csv file
                  FileUtils.mkdir_p "#{Dir.pwd}/_data/raw_images/#{coll}"
                  File.open("#{Dir.pwd}/_data/#{coll}.csv", "w") { |file| file.write("pid,label\n") }

                  new_config["collections"] ||= {}

                  # Add coll to new config stanzas
                  new_config["collections"][coll] = {
                    "output" => true,
                    "layout" => "wax_item",
                    "metadata" => { "source" => "#{coll}.csv" },
                    "images" => { "source" => "raw_images/#{coll}" }
                  }
                end

                new_config["waxified"] = true

                new_yaml = new_config.to_yaml.sub("---\n", "")
                config_text.sub! "\ncollections:\n", "\n#{new_yaml}"
                File.open("_config.yml", "w") { |f| f.puts config_text }
              end
            end
          end
        end
      end
    end
  end
end
