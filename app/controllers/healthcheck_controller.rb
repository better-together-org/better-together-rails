# frozen_string_literal: true

class HealthcheckController < ApplicationController # rubocop:todo Style/Documentation
  # Make healthcheck endpoint public and locale-agnostic
  skip_before_action :authenticate_user!, raise: false
  skip_before_action :set_locale, raise: false
  skip_before_action :check_platform_privacy, raise: false
  def index
    render json: { status: 'ok' }, status: :ok
  end
end
