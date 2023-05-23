class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototype = @user.prototypes
    @user_prototypes = current_user.prototypes
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :occupation, :position).merge(prototype_id: params[:user_id])
  end


end
