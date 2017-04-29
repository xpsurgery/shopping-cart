require 'hashie/mash'

class Challenges

  def initialize(config)
    @challenges = Hashie::Mash.new
    @config = config
  end

  def issue
    timestamp = Time.now
    id = '1234'
    challenge = Hashie::Mash.new({
      id: id,
      issuedAt: timestamp,
      expiresAt: timestamp + @config.sales.expiry_secs
    })
    @challenges[id] = challenge
    challenge
  end

  def answer(id, payload, on_success, on_error)
    errors = []
    errors << 'Please wait until the game is in progress' if @phase != :playing
    errors << 'Please supply your team name' unless payload.teamName
    if @challenges.has_key?(id)
      challenge = @challenges[id]
      errors << "Challenge #{id} has timed out" if Time.now < challenge.expiresAt
    else
      errors << "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
    end

    if errors.empty?
      on_success.call
    else
      on_error.call(Hashie::Mash.new({
        errors: errors
      }))
    end
  end

end

