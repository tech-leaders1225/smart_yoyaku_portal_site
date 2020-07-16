class Admin::AdminsController < Admin::Base
  before_action :authenticate_admin!, only: [:top]

end
