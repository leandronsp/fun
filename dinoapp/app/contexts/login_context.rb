class LoginContext < BaseContext
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    raise UnauthorizedError.new if not_found?

    User.new(*result.first)
  end

  private

  def result
    @result ||= UserRepository.find_by_email_and_password(@email, @password)
  end

  def not_found? = result.nil? || result.empty?
end
