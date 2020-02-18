class JournalsController < ApplicationController
  def index
    if params[:search]
      @journals = Journal.where('name LIKE ?', "%#{params[:search]}%")
    else
      @journals = Journal.all
    end
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
    if params[:search]
      @journal_entries = JournalEntry.where('journal_id = ? AND title LIKE ?', params[:id], "%#{params[:search]}%")
    else
      @journal_entries = @journal.journal_entries
    end

    @totals_for_week = totals_for_week(@journal, @journal_entries)
    @totals_for_month = totals_for_month(@journal, @journal_entries)
    @totals_for_year = totals_for_year(@journal, @journal_entries)
    @totals = totals(@journal, @journal_entries)
  end

  private
    def journal_params
      params.require(:journal).permit(:name, :search)
    end

    def totals(journal, entries)
      entry_ids = '('
      entries.each do |e|
        entry_ids += e.id.to_s + ','
      end
      entry_ids[entry_ids.length - 1] = ')'

      JournalEntry.find_by_sql(<<-SQL
        SELECT
          strftime('%m', created_at) AS month,
          count(*) AS count
        FROM journal_entries
        WHERE journal_id=#{journal.id} AND id IN #{entry_ids}
        GROUP BY month
        ORDER BY month
        SQL
      ).map do |row|
        [
          Date::MONTHNAMES[row['month'].to_i],
          row['count'],
        ]
    end
  end

    def totals_for_year(journal, entries)
      entry_ids = '('
      entries.each do |e|
        entry_ids += e.id.to_s + ','
      end
      entry_ids[entry_ids.length - 1] = ')'

      date = journal.created_at.to_time.strftime('%Y-%m-%d')
      JournalEntry.find_by_sql(<<-SQL
        SELECT
          strftime('%m', created_at) AS month,
          count(*) AS count
        FROM journal_entries
        WHERE journal_id=#{journal.id} AND created_at >= date(#{date}, '-1 year') AND id IN #{entry_ids}
        GROUP BY month
        ORDER BY month
        SQL
      ).map do |row|
        [
          Date::MONTHNAMES[row['month'].to_i],
          row['count'],
        ]
    end
  end

  def totals_for_month(journal, entries)
    entry_ids = '('
    entries.each do |e|
      entry_ids += e.id.to_s + ','
    end
    entry_ids[entry_ids.length - 1] = ')'

    date = journal.created_at.to_time.strftime('%Y-%m-%d')
    JournalEntry.find_by_sql(<<-SQL
      SELECT
        strftime('%d', created_at) AS day,
        COUNT(*) AS count
      FROM journal_entries
      WHERE journal_id=#{journal.id} AND created_at >= date(#{date}, '-1 month') AND id IN #{entry_ids}
      GROUP BY day
      ORDER BY day
      SQL
    ).map do |row|
      [
        row['day'],
        row['count'],
      ]
    end
  end

  def totals_for_week(journal, entries)
    entry_ids = '('
    entries.each do |e|
      entry_ids += e.id.to_s + ','
    end
    entry_ids[entry_ids.length - 1] = ')'

    date = journal.created_at.to_time.strftime('%Y-%m-%d')
    JournalEntry.find_by_sql(<<-SQL
      SELECT
        strftime('%d', created_at) AS day,
        COUNT(*) AS count
      FROM journal_entries
      WHERE journal_id=#{journal.id} AND created_at >= date(#{date}, '-7 days') AND id IN #{entry_ids}
      GROUP BY day
      ORDER BY day
      SQL
    ).map do |row|
      [
        row['day'],
        row['count'],
      ]
    end
  end
end
