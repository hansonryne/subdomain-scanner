class ComparisonsController < ApplicationController
  before_action :set_comparison, only: [:show, :destroy]

    # GET /comparisons/1
  # GET /comparisons/1.json
  def show
  end
  
  # POST /comparisons
  # POST /comparisons.json
  def create
#     render plain: params[:comparison].inspect
    @comparison = Comparison.new(comparison_params)
    
    
    
    respond_to do |format|
      if @comparison.save
        format.html { redirect_to @comparison, notice: 'Comparison was successfully generated.' }
        format.json { render :show, status: :created, location: @comparison }
        
      else
        if @comparison.comparer_id == @comparison.compared_id
          format.html { redirect_to scan_path(@comparison.comparer_id), flash: {error: "You can't compare a scan to itself"} }
        elsif @comparison.check_duplicate
          format.html { redirect_to comparison_path(@comparison.get_duplicate(@comparison)), flash: {error: "This comparison has already been created in the reverse order.  Here it is:"} }
        else
          format.html { redirect_to scan_path(@comparison.comparer_id), flash: {error: "An error has occured. Make sure you have selected a scan to compare to or that this comparison has not already been created"} }
        end
      end
    end
  end

  # DELETE /comparisons/1
  # DELETE /comparisons/1.json
  def destroy
    @comparison.destroy
#     respond_to do |format|
#       format.html { redirect_back fallback_location: root_path, notice: 'Comparison was successfully destroyed.' }
#       format.json { head :no_content }
#     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comparison
      @comparison = Comparison.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.require(:comparison).permit(:compared_id, :comparer_id)
    end

end
