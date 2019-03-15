require 'rails_helper'
RSpec.describe SomeController, type: :controller do
  before do
    admin = create(:admin) #FactoryGirl
    sign_in admin
  end
end