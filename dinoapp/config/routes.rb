class Routes
  ROUTES_TABLE = {
    'GET /'        => [HomeController, :index],
    'POST /login'  => [SessionsController, :create],
    'POST /logout' => [SessionsController, :destroy]
  }.freeze

  def self.lookup(request)
    controller_klass, action = ROUTES_TABLE["#{request.verb} #{request.path}"]

    return NotFoundController.dispatch(:show, request) unless controller_klass

    controller_klass.dispatch(action, request)
  end
end
