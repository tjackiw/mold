# Rails 2.X Template
if defined?(Rails) && Rails.version =~ /^2/
  module Mold
    class Handler < ActionView::TemplateHandler
      include ActionView::TemplateHandlers::Compilable

      def compile(template)
        source = if File.basename(template.filename).starts_with?('_')
          'code.call'
        else 
          'ActiveSupport::JSON.encode(code.call)'
        end
        %{
          controller.response.content_type = Mime::JSON
          code = lambda{#{ template.source }}
          self.output_buffer = (#{ src })
        }
      end
    end
  end
  ActionView::Template.register_template_handler(:mold, Mold::Handler)
end

# Rails 3.X Template
if defined?(Rails) && Rails.version =~ /^3/
  module Mold
    class Handler < ActionView::Template::Handler
      
      self.default_format = Mime::JSON

      def self.call(template)
        source = if File.basename(template.identifier).starts_with?('_')
          'code.call'
        else
          'ActiveSupport::JSON.encode(code.call)'
        end
        %{
          code = lambda{#{ template.source }}
          self.output_buffer = (#{ source })
        }
      end
    end
  end
  ActionView::Template.register_template_handler(:mold, Mold::Handler)
end
