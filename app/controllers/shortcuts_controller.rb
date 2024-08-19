class ShortcutsController < ApplicationController
  before_action :set_shortcut, only: %i[ show edit update destroy ]

  def redirect
    shortcut = Shortcut.find_by(short_url: params[:short_url])
    shortcut.accessed
    redirect_to shortcut.full_url, allow_other_host: true
  end

  def report
    @shortcuts = Shortcut.all.limit(100).order(click_count: :desc)
  end

  # GET /shortcuts or /shortcuts.json
  def index
    @shortcuts = Shortcut.all
  end

  # GET /shortcuts/1 or /shortcuts/1.json
  def show
  end

  # GET /shortcuts/new
  def new
    @shortcut = Shortcut.new
  end

  # GET /shortcuts/1/edit
  def edit
  end

  # POST /shortcuts or /shortcuts.json
  def create
    @shortcut = Shortcut.new(shortcut_params)

    respond_to do |format|
      if @shortcut.save
        format.html { redirect_to shortcut_url(@shortcut), notice: "Shortcut was successfully created." }
        format.json { render :show, status: :created, location: @shortcut }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shortcut.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shortcuts/1 or /shortcuts/1.json
  def update
    respond_to do |format|
      if @shortcut.update(shortcut_params)
        format.html { redirect_to shortcut_url(@shortcut), notice: "Shortcut was successfully updated." }
        format.json { render :show, status: :ok, location: @shortcut }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shortcut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shortcuts/1 or /shortcuts/1.json
  def destroy
    @shortcut.destroy!

    respond_to do |format|
      format.html { redirect_to shortcuts_url, notice: "Shortcut was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortcut
      @shortcut = Shortcut.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shortcut_params
      params.require(:shortcut).permit(:full_url)
    end
end
