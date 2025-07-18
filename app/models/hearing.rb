class Hearing < ApplicationRecord
  #-----------------------------------------------Associations---------------------------------------------
    belongs_to :court_case

  #------------------------------------------------Validations------------------------------------------

  has_many :documents, as: :documentable, dependent: :destroy
end
