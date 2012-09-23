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
        @logging
      end

      def create_indexes models_paths = nil
        models_paths ||= rails_models_paths

        raise ArgumentError, "No model paths for creating mongoid indexes" if models_paths.blank?
        message "CREATE INDEXES: #{models_paths}"

        models_paths.each do |path|
          ::Rails::Mongoid.create_indexes("#{path}/**/*.rb")
        end
      end

      def remove_indexes models_paths = nil
        models_paths ||= rails_models_paths

        raise ArgumentError, "No model paths for creating mongoid indexes" if models_paths.blank?
        message "REMOVING INDEXES: #{models_paths}"

        models_paths.each do |path|
          ::Rails::Mongoid.remove_indexes("#{path}/**/*.rb")
        end
      end

      def rails_models_paths
        engines_models_paths = Rails.application.railties.engines.map do |engine|
          engine.paths["app/models"].expanded
        end
        root_models_paths = Rails.application.paths["app/models"]
        engines_models_paths.push(root_models_paths).flatten
      end 

      protected

      def message txt
        puts txt if log?
      end         
    end
  end
end