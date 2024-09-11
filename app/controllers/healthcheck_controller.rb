# frozen_string_literal: true

class HealthcheckController < ApplicationController # rubocop:todo Style/Documentation
  def index
    render json: { status: 'ok' }, status: :ok
  end
end
