require 'active_support/core_ext/hash/conversions'
require 'action_dispatch/http/request'
require 'active_support/core_ext/hash/indifferent_access'

module ActionDispatch
  class XmlParamsParser
    def initialize(app)
      @app = app
    end

    def call(env)
      if params = parse_formatted_parameters(env)
        env["action_dispatch.request.request_parameters"] = params
      end

      @app.call(env)
    end

    private
      def parse_formatted_parameters(env)
        request = Request.new(env)

        return false if request.content_length.zero?

        mime_type = content_type_from_legacy_post_data_format_header(env) ||
          request.content_mime_type

        if mime_type == Mime[:xml]
          # Rails 5 removed #deep_munge and replaced it with #normalize_encode_params
          munger = defined?(Request::Utils) ? Request::Utils : request
          params = Hash.from_xml(request.body.read) || {}

          data = munger.normalize_encode_params(params)
          request.body.rewind if request.body.respond_to?(:rewind)
          data.with_indifferent_access
        else
          false
        end
      rescue Exception => e # XML code block errors
        logger(env).debug "Error occurred while parsing request parameters.\nContents:\n\n#{request.raw_post}"

        raise ActionDispatch::ParamsParser::ParseError.new(e.message, e)
      end

      def content_type_from_legacy_post_data_format_header(env)
        if env['HTTP_X_POST_DATA_FORMAT'].to_s.downcase == 'xml'
          Mime[:xml]
        end
      end

      def logger(env)
        env['action_dispatch.logger'] || ActiveSupport::Logger.new($stderr)
      end
  end
end
