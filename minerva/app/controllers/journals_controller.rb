class JournalsController < ApplicationController
  def index
    @journals = Journal.all
  end

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      redirect_to '/journals'
    else
      render 'new'
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy
    redirect_to :action => :index, status: 303
  end

  def show
    @journal = Journal.find(params[:id])
    @journal_entries = @journal.journal_entries
  end

  private
    def journal_params
      params.require(:journal).permit(:name)
    end
end
