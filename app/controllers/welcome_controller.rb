# frozen_string_literal: true

class WelcomeController < ApplicationController # rubocop:todo Style/Documentation
  def index
    respond_to(&:html)
  end
end
