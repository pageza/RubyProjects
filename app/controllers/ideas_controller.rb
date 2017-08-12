class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    @user = User.find(session[:user_id])
  end

  def show
    @idea = Idea.find(params[:id])
    @likes = Like.where(idea_id: @idea.id)
  end

  def create
    idea = Idea.new idea_params
    unless idea.save
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to "/bright_ideas"
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy if @idea.user === current_user
    redirect_to "/bright_ideas"
  end

  private
    def idea_params
      params.require(:idea).permit(:content).merge(user: current_user)
    end
end
