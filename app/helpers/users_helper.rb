module UsersHelper
  def current_user_full_name
    current_user&.full_name
  end

  def current_user_first_name
    current_user&.name
  end
end
