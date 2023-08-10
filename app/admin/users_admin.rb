Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    text_field :username
    row { datetime_field :updated_at }
    row { datetime_field :created_at }
    row { select :role, options_for_select(User.roles.map {|key, value| [key.titleize, User.roles.key(value)]}, user.role) }
    # row do
    #   col { datetime_field :updated_at }
    #   col { datetime_field :created_at }
    # end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
