require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  describe "#create" do
    context "not login" do
      it "200" do
        post comments_path
        expect(response.status).to eq 302
      end
    end
  end
end
