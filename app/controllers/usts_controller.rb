class USTsController < ApplicationController

  def index
    @ust = UST.new(params[:ust].present?? ust_params : {})
    @progression = @ust.generate_progression
  end

  private
    def ust_params
      params.require(:ust).permit(dominant_seventh_extensions: [],
                                  major_seventh_extensions: [],
                                  minor_seventh_extensions: [],
                                  minor_seventh_flat_five_extensions: [],
                                  diminished_seventh_extensions: [])
    end
end
