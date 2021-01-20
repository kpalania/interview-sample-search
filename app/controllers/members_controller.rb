require 'open-uri'

class MembersController < ApplicationController
  #
  #
  #
  def index
    render json: Member.all
  end

  #
  #
  #
  def member_by_name
    @member = Member.find_by_name params[:member_name]
    render json: @member.attributes.merge(@member.friends)
  end

  #
  #
  #
  def create
    @member = Member.create_member params: member_params
    if @member
      render json: @member, status: :created, location: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  #
  #
  #
  def add_friend
    member_name, friend_name = params[:member_name], member_params[:friend_name]
    @member = Member.find_by_name(member_name.downcase)
    @member.add_friend friend_name: friend_name
  end

  #
  #
  #
  def find_experts
    render json: Member.find_experts(token: params[:search_token], member_name: params[:member_name])
  end

  #
  # Private
  #

  private

  #
  # Only allow a trusted parameter "white list" through.
  #
  def member_params
    params.require(:member).permit(:name, :website, :friend_name)
  end
end
