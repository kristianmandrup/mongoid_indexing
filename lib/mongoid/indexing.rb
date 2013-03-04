module Mongoid
  module Indexing
    class << self
      attr_writer :logging

      def log_on!
        @logging = true
      end

      def log_off!
        @logging = false
      end

      def log?
        @logging ||= false
      end

      def create_indexes models_paths = nil
        message "creating mongoid indexes..."
        models_paths = rails_models_paths if models_paths == :rails

        load_models_from_paths models_paths

        ::Rails::Mongoid.create_indexes
      end

      def remove_indexes models_paths = nil
        message "removing mongoid indexes..."

        models_paths = rails_models_paths if models_paths == :rails

        load_models_from_paths models_paths

        ::Rails::Mongoid.remove_indexes 
      end

      def load_models_from_paths *models_paths
        [models_paths].flatten.compact.each do |path|
          require "#{path}/**/*.rb" unless path.blank?
        end
      end

      def rails_models_paths
        engines_models_paths = ::Rails.application.railties.engines.map do |engine|
          engine.paths["app/models"].expanded
        end
        root_models_paths = ::Rails.application.paths["app/models"]
        engines_models_paths.push(root_models_paths).flatten
      end 

      protected

      def message txt
        puts txt if log?
      end         
    end
  end
end