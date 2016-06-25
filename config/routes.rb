Rails.application.routes.draw do
  root 'grammars#index'

  resource :grammar, only: [:index, :new]
end
