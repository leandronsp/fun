class HomeContext < BaseContext
  def initialize(email)
    @email = email
  end

  def call
    return unless @email
    return if not_found?

    User.new(*result.first)
  end

  private

  def result
    @result ||= UserRepository.find_by_email(@email)
  end

  def not_found? = result.nil? || result.empty?
end
