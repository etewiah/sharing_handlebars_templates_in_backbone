# Be sure to restart your server when you modify this file.
#
require 'handlebars'

module HBSTemplateHandler
  def self.call(template)
    if template.locals.include? 'hbs'
      <<-SHT
        hbs_context_for_sht = Handlebars::Context.new
        partials.each do |key, value|
          hbs_context_for_sht.register_partial(key, value)
        end if defined?(partials) && partials.is_a?(Hash)
        hbs_context_for_sht.compile(#{template.source.inspect}).call(hbs || {}).html_safe
      SHT
      #<<-TEMPLATE
      #template = Handlebars.compile #{template.source.inspect}
      #template.call(hbs || {}).html_safe
      #TEMPLATE
    else
      <<-SOURCE
      #{template.source.inspect}.html_safe
      SOURCE
    end
  end
end

# Register HBS template handler to render Handlebars templates
ActionView::Template.register_template_handler(:hbs, HBSTemplateHandler)

# Make HBS'es of handlebars_assets usable from ruby
ActionController::Base.append_view_path "app/assets/templates"