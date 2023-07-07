class SessionsController < BaseController
  def destroy
    redirect({
      'Set-Cookie' => 'email=; path=/; HttpOnly; Expires=Thu, 01 Jan 1970 00:00:00 GMT',
      'Location' => "http://#{@request.headers['Host'] || 'localhost:3000'}/"
    })
  end

  def create
    email    = @request.params['email']
    password = @request.params['password']
    user     = LoginContext.call(email, password)

    redirect({
      'Set-Cookie' => "email=#{user.email}; path=/; HttpOnly",
      'Location' => "http://#{@request.headers['Host'] || 'localhost:3000'}/"
    })
  end
end
