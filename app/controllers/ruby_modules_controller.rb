class RubyModulesController < ApplicationController
  before_action :set_ruby_module, only: %i[ show edit update destroy ]

  # GET /ruby_modules or /ruby_modules.json
  def index
    @ruby_modules = RubyModule.all
  end

  # GET /ruby_modules/1 or /ruby_modules/1.json
  def show
  end

  # GET /ruby_modules/new
  def new
    @ruby_module = RubyModule.new
  end

  # GET /ruby_modules/1/edit
  def edit
  end

  # POST /ruby_modules or /ruby_modules.json
  def create
    @ruby_module = RubyModule.new(ruby_module_params)

    respond_to do |format|
      if @ruby_module.save
        format.html { redirect_to ruby_module_url(@ruby_module), notice: "Ruby module was successfully created." }
        format.json { render :show, status: :created, location: @ruby_module }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ruby_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ruby_modules/1 or /ruby_modules/1.json
  def update
    respond_to do |format|
      if @ruby_module.update(ruby_module_params)
        format.html { redirect_to ruby_module_url(@ruby_module), notice: "Ruby module was successfully updated." }
        format.json { render :show, status: :ok, location: @ruby_module }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ruby_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ruby_modules/1 or /ruby_modules/1.json
  def destroy
    @ruby_module.destroy

    respond_to do |format|
      format.html { redirect_to ruby_modules_url, notice: "Ruby module was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ruby_module
      @ruby_module = RubyModule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ruby_module_params
      params.require(:ruby_module).permit(:name)
    end
end
