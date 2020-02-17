class Journal < ApplicationRecord
  has_many :journal_entries, dependent: :destroy
end
