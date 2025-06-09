class CaseLawyer < ApplicationRecord
  belongs_to :court_case, foreign_key: :case_id, optional: true
  belongs_to :lawyer
end
