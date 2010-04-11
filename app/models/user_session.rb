class UserSession < Authlogic::Session::Base
  def change_hash
    self.user.change_hash
  end
end