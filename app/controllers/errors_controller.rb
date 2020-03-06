class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def not_found

  end

  def unacceptable

  end

  def internal_error
  end
end
