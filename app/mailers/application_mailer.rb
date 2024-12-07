# frozen_string_literal: true

class ApplicationMailer < ::BetterTogether::ApplicationMailer # rubocop:todo Style/Documentation
  default from: 'from@example.com'
  layout 'mailer'
end
