class BannedIpsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @banned_ip = BannedIp.new(ip_params)
    authorize @banned_ip
    @banned_ip.save!
    redirect_to :back
  end

  def destroy
    @banned_ip = BannedIp.find(params[:id])
    authorize @banned_ip
    @banned_ip.destroy

    redirect_to :back
  end

private

  def ip_params
    params.require(:banned_ip).permit(:ip)
  end
end
