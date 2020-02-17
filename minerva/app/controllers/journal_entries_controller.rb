class JournalEntriesController < ApplicationController
  def new
    @journal_entry = JournalEntry.new
    @journal_id = params[:journal_id]
  end

  def create
    @journal_entry = JournalEntry.new(journal_entries_params)

    if @journal_entry.save
      redirect_to journal_journal_entry_path(:id => @journal_entry.id)
    else
      render 'new'
    end
  end

  def destroy
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.destroy
    redirect_to :controller => :journals, :action => :show, :id => params[:journal_id], status: 303
  end

  def show
    @journal_entry = JournalEntry.find(params[:id])
    @journal = Journal.find(@journal_entry.journal_id)
  end

  def edit
    @journal_entry = JournalEntry.find(params[:id])
  end

  def update
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.update(journal_entry_params)
    redirect_to :controller => :journal_entries, :action => :show, :id => @journal_entry.id
  end

  private
    def journal_entries_params
      params.require(:journal_entries).permit(:title, :body, :journal_id, :edited)
    end

    def journal_entry_params
      params.require(:journal_entry).permit(:title, :body, :journal_id, :edited)
    end
end
