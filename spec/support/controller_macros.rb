module ControllerMacros
  def sign_in_user
    before(:each) do |example|
      unless example.metadata[:skip_sign_in]
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
      end
    end
  end
end
