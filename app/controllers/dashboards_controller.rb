class DashboardsController < ApplicationController
 def index
   @users_count = User.count
   @clients_count = Client.count
   @lawyers_count = Lawyer.count
   @total_cases = CourtCase.count
 end
end
