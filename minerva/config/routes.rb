Rails.application.routes.draw do
  get 'journals/index'
  get 'home' => 'journals#index'

  resources :journals, only: [:index, :destroy, :show, :create, :new] do
    resources :journal_entries, path: "", path_names:
    {
      new: "add_journal_entry",
      create: "add_journal_entry",
      destroy: "remove_journal_entry",
      show: "show_journal_entry",
      edit: "update_journal_entry",
      update: "update_journal_entry"
    }, only: [:new, :create, :destroy, :show, :edit, :update]
  end

  root 'journals#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
