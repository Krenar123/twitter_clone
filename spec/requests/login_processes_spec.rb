require 'rails_helper'

RSpec.describe "LoginProcesses", type: :request do
  describe "GET /login_processes" do
    it "works! (now write some real specs)" do
      get login_processes_path
      expect(response).to have_http_status(200)
    end
  end
end
