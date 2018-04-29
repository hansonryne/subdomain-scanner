class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
    @comparison = Comparison.new
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans
  # POST /scans.json
  def create
    render plain: params.inspect
#     @scan = Scan.new(scan_params)

#     respond_to do |format|
#       if @scan.save
#         subdomain_recs = ["these", "are", "tests", "too"]
#         subdomain_recs.each do |s|
#           SubdomainRecord.create(name: s, scan_id: "#{@scan.id}")
#         end
#         format.html { redirect_to @scan, notice: 'Scan was successfully created.' }
#         format.json { render :show, status: :created, location: @scan }
#       else
#         format.html { render :new }
#         format.json { render json: @scan.errors, status: :unprocessable_entity }
#       end
#     end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to @scan, notice: 'Scan was successfully updated.' }
        format.json { render :show, status: :ok, location: @scan }
      else
        format.html { render :edit }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.destroy
    respond_to do |format|
      format.html { redirect_to scans_url, notice: 'Scan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:name, :brute, :threads)
    end
end
