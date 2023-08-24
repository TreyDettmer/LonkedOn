class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @companies = Company.all
    if !current_user || (current_user && !current_user.admin?)
      respond_to do |format|
        format.html { redirect_to job_posts_url}
      end
    end
  end

  # GET /companies/1 or /companies/1.json
  def show
    if !current_user || (current_user && !current_user.admin?)
      respond_to do |format|
        format.html { redirect_to job_posts_url}
      end
    end
  end

  # GET /companies/new
  def new
    if !current_user || (current_user && !current_user.admin?)
      respond_to do |format|
        format.html { redirect_to job_posts_url}
      end
    else
      @company = Company.new
    end
  end

  # GET /companies/1/edit
  def edit
    if !current_user || (current_user && !current_user.admin?)
      respond_to do |format|
        format.html { redirect_to job_posts_url}
      end
    end
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      format.html { redirect_to job_posts_url}
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    if current_user && current_user.admin?
      @company.destroy

      respond_to do |format|
        format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:title, :location, :image)
    end
end
