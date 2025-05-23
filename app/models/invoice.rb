class Invoice < ApplicationRecord
  belongs_to :case
  belongs_to :issued_to, class_name: "User"
end
