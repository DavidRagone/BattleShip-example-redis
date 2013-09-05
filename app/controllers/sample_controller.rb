class SampleController < ApplicationController
  def get
    @hits = Rails.cache.hits("user") || 0
    @misses = Rails.cache.misses("user") || 0
  end

  def find_user
    Rails.cache.read("user_#{params[:id]}")
    redirect_to :root
  end

  def create_user
    if max_records_created
      set_flash_alert
    else
      fetch_or_create
    end
    redirect_to :root
  end

  private
  def max_records_created
    User.where(ip_address: request.ip).count > 4
  end

  def set_flash_alert
    flash[:alert] = "That's enough, now (you've created more than 4 records already)"
  end

  def fetch_or_create
    Rails.cache.fetch("user_#{params[:id]}") do
      User.create(uid: params[:id], ip_address: request.ip)
    end
  end
end
