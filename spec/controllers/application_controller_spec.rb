# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include RequestSpecHelper
  before { configure_host_platform }

  controller(described_class) do
    # Avoid redirects from authentication/locale filters defined upstream
    skip_before_action :authenticate_user!, raise: false
    skip_before_action :set_locale, raise: false
    def raise_and_report
      raise 'boom'
    rescue StandardError => e
      error_reporting(e)
      render plain: 'handled'
    end
  end
end
