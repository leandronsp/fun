class BaseController
  VIEWS_PATH = './app/views'.freeze

  def initialize(request)
    @request  = request
  end

  def self.dispatch(action, request)
    new(request).send(action.to_sym)
  rescue UnauthorizedError
    new(request).unauthorized
  rescue NotFoundError
    new(request).not_found
  end

  def not_found    = [404, default_header, not_found_view]
  def unauthorized = [401, default_header, unauthorized_view]

  def success(headers, body) = [200, headers, body]
  def redirect(headers)      = [301, headers, '']

  def default_header = { 'Content-Type' => 'text/html' }

  def not_found_view    = view('not_found')
  def unauthorized_view = view('unauthorized')
  def view(name)        = File.read("#{VIEWS_PATH}/#{name}.html")
end
