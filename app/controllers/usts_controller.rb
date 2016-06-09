class USTsController < ApplicationController

  def index
    @ust = UST.new ust_params
    @progression = @ust.generate_progression
  end

  private
    def ust_params
      params.permit(:ust).permit(:dominant_enabled, :major_enabled, :minor_enabled, :minor_flat_five_enabled, :diminished_enabled)
    end
end
