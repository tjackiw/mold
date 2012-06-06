if defined?(Rails) && Rails.version =~ /^3/
  
  require('yajl/json_gem') if defined?(Yajl)

  class ActionView::Template
    module Handlers
      class Mold
        default_format = Mime::JSON

        def call(template)
          source = if File.basename(template.identifier).starts_with?('_')
            'code.call'
          else
            defined?(Yajl) ? 'JSON.generate(code.call)' : 'ActiveSupport::JSON.encode(code.call)'
          end
          %{
            code = lambda{#{ template.source }}
            self.output_buffer = (#{ source })
          }
        end

      end
    end
    register_template_handler(:mold, Handlers::Mold.new)
  end
  
end
