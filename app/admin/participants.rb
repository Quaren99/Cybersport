ActiveAdmin.register Participant do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :tournament_id, :team_id, :place, :prize
  #
  # or
  #
  # permit_params do
  #   permitted = [:tournament_id, :team_id, :place, :prize]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
