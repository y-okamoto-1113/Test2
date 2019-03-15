module AuthenticationMacros
  def login
    # let(:admin) { Admin.create(name:'ccc',
    #                      email:'test4@example.com',
    #                      password:'password') }
    let(:admin) {create(:admin)}  # 上の3行分の書き換え。 buildやとセッション保持しやんけど、createやと保持する。
    before do
      # binding.pry
      sign_in admin
      # binding.pry
    end 
  end
end