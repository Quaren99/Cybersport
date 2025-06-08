ActiveAdmin.register Member do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :player_id, :team_id, :joined, :left
  #
  # or
  #
  # permit_params do
  #   permitted = [:player_id, :team_id, :joined, :left]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
