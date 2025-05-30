class DashboardsController < ApplicationController

 def index
   @users_count = User.count
   @clients_count = Client.count
   @lawyers_count = Lawyer.count
   @judges_count = Judge.count
 end
end