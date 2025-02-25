# frozen_string_literal: true

require 'zeitwerk'
Zeitwerk::Loader.for_gem.setup

module MjmlRender
  def self.included(base)
    super
    base.prepend_view_path(MjmlRender::Compiler::COMPILED_TEMPLATES_PATH)
    base.layout(false)

    base.extend MjmlRender::Compiler
  end
end
