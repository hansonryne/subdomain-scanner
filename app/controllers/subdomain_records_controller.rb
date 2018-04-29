class SubdomainRecordsController < ApplicationController
  before_action :set_subdomain_record, only: [:show, :edit, :update, :destroy]

  # GET /subdomain_records
  # GET /subdomain_records.json
  def index
    @subdomain_records = SubdomainRecord.all
  end

  # GET /subdomain_records/1
  # GET /subdomain_records/1.json
  def show
  end

  # GET /subdomain_records/new
  def new
    @subdomain_record = SubdomainRecord.new
  end

  # GET /subdomain_records/1/edit
  def edit
  end

  # POST /subdomain_records
  # POST /subdomain_records.json
  def create
    @subdomain_record = SubdomainRecord.new(subdomain_record_params)

    respond_to do |format|
      if @subdomain_record.save
        format.html { redirect_to @subdomain_record, notice: 'Subdomain record was successfully created.' }
        format.json { render :show, status: :created, location: @subdomain_record }
      else
        format.html { render :new }
        format.json { render json: @subdomain_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subdomain_records/1
  # PATCH/PUT /subdomain_records/1.json
  def update
    respond_to do |format|
      if @subdomain_record.update(subdomain_record_params)
        format.html { redirect_to @subdomain_record, notice: 'Subdomain record was successfully updated.' }
        format.json { render :show, status: :ok, location: @subdomain_record }
      else
        format.html { render :edit }
        format.json { render json: @subdomain_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subdomain_records/1
  # DELETE /subdomain_records/1.json
  def destroy
    @subdomain_record.destroy
    respond_to do |format|
      format.html { redirect_to subdomain_records_url, notice: 'Subdomain record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subdomain_record
      @subdomain_record = SubdomainRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subdomain_record_params
      params.fetch(:subdomain_record, {})
    end
end
