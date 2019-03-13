module AuthenticationMacros
  def login
    # let(:admin) { Admin.create(name:'ccc',
    #                      email:'test4@example.com',
    #                      password:'password') }
    let(:admin) {create(:admin)}  # 上の3行分の書き換え。 buildやとセッション保持しやんけど、createやと保持する。
    before do
      sign_in admin
    end 
  end
end