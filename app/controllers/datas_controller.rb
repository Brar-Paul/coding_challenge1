require 'csv'

class DatasController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :server_auth

  def upload
    # retreive csv from body of request
    data = params[:data].open
    # parse the csv and save values for each line into variables
    csv_options = { col_sep: ',', headers: :first_row }
    CSV.parse(data, csv_options) do |timestamp, lock_id, kind, status_change|
      lock = Lock.find_by(id: lock_id[1])
      # Check if lock exists to either update or create the lock
      if lock
        lock.status = status_change[1]
        lock.save
      else
        # if lock doesn't exist then create it with values from csv line
        lock = Lock.create(id: lock_id[1], kind: kind[1], status: status_change[1])
      end
      # create an entry from each csv line
      Entry.create(timestampe: timestamp[1], status_change: status_change[1], lock: lock)
    end
  end

  def server_auth
    code_name = request.headers["X-Server-CodeName"]
    access_token = request.headers["X-Server-AccessToken"]
    server = Server.find_by(code_name: code_name)
    unless server && server.access_token == access_token
      render json: { message: "Not Authorized" }
    end
  end
end
