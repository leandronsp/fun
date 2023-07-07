class HomeController < BaseController
  def index
    email = @request.cookies['email']
    user  = HomeContext.call(email)

    if user
      success(
        default_header,
        view('home').gsub(/{{email}}/, user.email)
      )
    else
      success(default_header, view('login'))
    end
  end
end
