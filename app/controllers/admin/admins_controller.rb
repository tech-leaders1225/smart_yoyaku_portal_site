class AdminsController < Admin::Base
  before_action :authenticate_admin!, only: [:top]

  def top
  end
end
