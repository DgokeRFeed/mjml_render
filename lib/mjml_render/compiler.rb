# frozen_string_literal: true

module MjmlRender
  module Compiler
    BASE_PATH = Rails.root.join('app/views/mjml')
    COMPILED_TEMPLATES_PATH = Rails.root.join('app/views/mjml/compiled')

    def disabled_mjml_actions
      @disabled_mjml_actions || []
    end

    def mjml_mailer_templates_path
      BASE_PATH.join(name.underscore)
    end

    def mjml_mailer_compiled_templates_path(dest_path)
      dest_path.join(name.underscore)
    end

    def mjml_action_template(action)
      mjml_mailer_templates_path.join("#{action}.mjml")
    end

    def mjml_compiled_action_template(action, dest_path)
      mjml_mailer_compiled_templates_path(dest_path).join("#{action}.html.erb")
    end

    def precompile!
      actions_for_mjml = instance_methods(false).map(&:to_s) - disabled_mjml_actions

      actions_for_compilation =
        Dir["#{mjml_mailer_templates_path}/*.mjml"].filter_map do |file|
          mjml_file = file.split('/').last.gsub('.mjml', '')

          next unless mjml_file.in?(actions_for_mjml)

          mjml_file
        end

      actions_for_compilation.each { mjml_compile_action!(_1, COMPILED_TEMPLATES_PATH) }
    end

    def mjml_compile_action!(action, dest_path)
      FileUtils.mkdir_p(mjml_mailer_compiled_templates_path(dest_path))

      source = mjml_action_template(action).to_s
      dest = mjml_compiled_action_template(action, dest_path).to_s

      Rails.logger.info("MJML: compiling #{source} to #{dest}")

      system(
        'mjml',
        source,
        '-o',
        dest,
        '--validate',
        '--config.filePath',
        BASE_PATH.to_s,
        exception: true
      )
    end

    def disable_mjml(name)
      @disabled_mjml_actions ||= []

      @disabled_mjml_actions << name.to_s
    end
  end
end
