# frozen_string_literal: true

require "deep_merge"
require "yaml"

module Jekyll
  module Waxify
    # JekyllConfig: represents _config.yml in text and yaml
    class JekyllConfig
      attr_reader :yaml, :text, :new_config, :jekyll_dir

      def initialize(framework_dir, jekyll_dir, new_config = {})
        @framework_dir = framework_dir
        @jekyll_dir = jekyll_dir
        @text = File.read("#{@jekyll_dir}/_config.yml")
        @yaml = YAML.safe_load(@text)
        @new_config = new_config
      end

      def waxified
        @yaml["waxified-hide"]
      end

      def deploy_framework
        # copy framework documents to jekyll
        FileUtils.cp_r @framework_dir, @jekyll_dir
      end

      def add(to_add)
        @new_config.deep_merge! to_add
      end

      def add_cors
        # Add CORS stanza to _config.yml
        add(
          {
            "webrick" => {
              "header" => {
                "Access-Control-Allow-Origin" => "*"
              }
            }
          }
        )
      end

      def add_collection(coll)
        return unless coll

        # Add collection key (used in @text.sub below)
        @text += "\ncollections:\n" unless @yaml["collections"]

        # Make coll images dir and metadata csv file
        FileUtils.mkdir_p "#{@jekyll_dir}/_data/raw_images/#{coll}"
        File.open("#{@jekyll_dir}/_data/#{coll}.csv", "w") { |file| file.write("pid,label\n") }

        @yaml["collections"] ||= {}

        # TODO: error if coll already exists in @yaml

        # Add coll to new config stanzas
        add(
          { "collections" => {
            coll =>
              {
                "output" => true,
                "layout" => "wax_item",
                "metadata" => { "source" => "#{coll}.csv" },
                "images" => { "source" => "raw_images/#{coll}" }
              }
          } }
        )
      end

      def merge
        @new_config["waxified"] = true

        new_yaml = @new_config.to_yaml.sub("---\n", "")
        @text.sub! "\ncollections:\n", "\n#{new_yaml}"
      end

      def save
        File.open("_config.yml", "w") { |f| f.puts @text }
      end
    end
  end
end
