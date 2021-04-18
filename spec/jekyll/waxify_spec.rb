# frozen_string_literal: true

require "jekyll/commands/waxify"
require "jekyll/waxify"
require "setup"

RSpec.describe Jekyll::Waxify do
  it "has a version number" do
    expect(Jekyll::Waxify::VERSION).not_to be nil
  end
end

RSpec.describe Jekyll::Waxify::JekyllConfig do
  before(:all) do
    Test.reset
  end

  after(:all) do
    FileUtils.rm_rf(BUILD)
  end

  describe "#new" do
    context "when initialized with valid config hash from file" do
      it "runs without errors" do
        expect { Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD) }.not_to raise_error
      end
    end
  end

  describe "#add_cors" do
    context "when initialized with valid config hash from file" do
      it "adds a CORS section to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD)
        result.add_cors
        expect(result.new_config.dig("webrick", "header", "Access-Control-Allow-Origin")).to eq("*")
      end
    end
    context "when initialized with valid config hash from file with CORS section" do
      it "does not add a CORS section to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD, {}, "_config_with_cors.yml")
        result.add_cors
        expect(result.new_config.dig("webrick", "header", "Access-Control-Allow-Origin")).to be nil
      end
    end
  end

  describe "#deploy_framework" do
    context "when initialized with valid config hash from file" do
      it "deploys the framework to the Jekyll instance" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD)
        result.deploy_framework
        file_exists = File.file?("#{result.jekyll_dir}/collections.markdown")
        expect(file_exists).to be true
      end
    end
  end

  describe "#add_collection" do
    context "when initialized with valid config hash from file" do
      it "adds a collection to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD)
        result.add_collection("test-collection")
        expect(result.new_config.dig("collections", "test-collection", "metadata",
                                     "source")).to eq("test-collection.csv")
      end
    end
    context "when initialized with valid config hash from file" do
      it "does not add a pre-existing collection to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD)
        result.add_collection("csv_collection")
        expect(result.new_config.dig("collections", "csv_collection")).to be nil
      end
    end
  end

  describe "#merge" do
    context "when initialized with valid config hash from file" do
      it "merges new_config into yaml" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD, { "waxified" => true })
        result.merge
      end
    end
    context "when initialized with valid config hash from file with no collections" do
      it "adds a collection to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD, {}, "_config_without_collections.yml")
        result.add_collection("test-collection")
        result.merge
        expect(YAML.safe_load(result.text).dig("collections", "test-collection", "metadata",
                                     "source")).to eq("test-collection.csv")
      end
    end
    context "when initialized with valid config hash from file with collections at end" do
      it "adds a collection to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD, {}, "_config_with_collections_at_end.yml")
        result.add_collection("test-collection")
        result.merge
        expect(YAML.safe_load(result.text).dig("collections", "test-collection", "metadata",
                                     "source")).to eq("test-collection.csv")
        expect(result.text.scan(/^collections:/).count).to eq(1)
      end
    end
    context "when initialized with valid config hash from file with comments" do
      it "adds a collection to new_config" do
        result = Jekyll::Waxify::JekyllConfig.new(Jekyll::Waxify::WAXIFY_FRAMEWORK, BUILD, {}, "_config_with_comment.yml")
        result.add_collection("test-collection")
        result.merge
        expect(YAML.safe_load(result.text).dig("collections", "test-collection", "metadata",
                                     "source")).to eq("test-collection.csv")
        expect(result.text.scan(/^collections:/).count).to eq(1)
      end
    end
  end
end
