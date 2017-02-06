ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :email

  controller do
    def create
      @user = User.invite!(permitted_params[:user], current_admin)
      if @user.new_record?
        render action: 'new'
      else
        redirect_to resource_path(@user), notice: 'User invited successfully!'
      end
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :invited_by
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :invited_by, :as => :select, :collection => Admin.all.collect{|admin| [admin.email, admin.id]}

  form do |f|
    f.inputs "Invite User #{current_admin.inspect}" do
      f.input :email
    end
    f.actions
  end

end
