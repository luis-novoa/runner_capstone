class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    
  end

  def index
    @all_groups = Group.all
  end
end
