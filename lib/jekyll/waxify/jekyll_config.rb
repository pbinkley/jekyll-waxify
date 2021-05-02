# frozen_string_literal: true

require "deep_merge"
require "yaml"

module Jekyll
  module Waxify
    # JekyllConfig: represents _config.yml in text and yaml
    class JekyllConfig
      attr_reader :yaml, :text, :new_config, :jekyll_dir

      def initialize(framework_dir, jekyll_dir, new_config = {}, config_file = "_config.yml")
        @framework_dir = framework_dir
        @jekyll_dir = jekyll_dir
        @config_file = config_file
        @text = File.read("#{@jekyll_dir}/#{@config_file}")
        @yaml = YAML.safe_load(@text)
        @new_config = new_config
      end

      def waxified
        @yaml["waxified"]
      end

      def deploy_framework
        # copy framework documents to jekyll
        FileUtils.cp_r @framework_dir, @jekyll_dir
      end

      def add(to_add)
        @new_config.deep_merge! to_add
      end

      def add_cors
        return if @yaml.dig("webrick", "header", "Access-Control-Allow-Origin")

        # Add CORS stanza to _config.yml
        add(
          {
            "webrick" => {
              "headers" => {
                "Access-Control-Allow-Origin" => "*"
              }
            }
          }
        )
      end

      def add_collection(coll)
        return unless coll

        # Make coll images dir and metadata csv file
        FileUtils.mkdir_p "#{@jekyll_dir}/_data/raw_images/#{coll}"
        File.open("#{@jekyll_dir}/_data/#{coll}.csv", "w") { |file| file.write("pid,label\n") }

        @yaml["collections"] ||= {}

        return if @yaml.dig("collections", coll)

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
        
        # collection block is terminated by EOF or a new key, i.e. a line 
        # that begins a character other than whitespace or hash

        groups = @text.match /(^collections:.*\n.+\n)(\Z|[^\s\#].*)/m

        if groups.nil?
          # there are no collections in initial yaml, so append new_yaml
          @text += new_yaml
        else
          # merge collections from @new_config into collections
          collections = YAML.safe_load(groups[1])
          collections.deep_merge! @new_config

          @text = groups.pre_match + collections.to_yaml.sub("---\n","") + groups[2]
        end
      end

      def save
        File.open(@config_file, "w") { |f| f.puts @text }
      end
    end
  end
end
