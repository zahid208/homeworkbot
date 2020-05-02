class PlaceBid
  attr_reader :session
  attr_reader :assignment

  def self.call(session, assignment)
    self.new(session, assignment).call
  end

  def initialize (session, assignment)
    @session = session
    @assignment= assignment
  end

  def call
    session.visit(assignment.link)

    if session.has_css?(".teacher-question", wait: 10)
      if session.has_css?(".teacher-question .btn-success")
        assignment.bid_placed
        # session.find('.teacher-question .btn-success').click
        # if session.has_css?('.msg-form #msg', wait: 5)
        #   session.find('.msg-form #msg').set(past_body)
        #   session.find('.msg-form .send-button').click
        # end
      else
        session.first(".teacher-question .btn-primary", minimum: 1).click
        if session.has_css?(".Popover-body", wait: 2)
          inputs = session.all('.form-control')
          inputs[1].set(price(inputs[0].value))
          inputs[2].set(body)
          session.find('.btn.btn-warning.style-1').click
          if session.has_css?(".teacher-question .btn-success")
            assignment.bid_placed
            # session.find('.teacher-question .btn-success').click
            # if session.has_css?('.msg-form #msg', wait: 5)
            #   session.find('.msg-form #msg').set(past_body)
            #   session.find('.msg-form .send-button').click
            # end
          end
        end
      end
    end
  end

  private
    def body
      return assignment.account_bid_content.sub('[FIELD]', assignment.field) if assignment.account.present?
      "Hello.
        I am an expert in #{assignment.field}
        I have read and understood all the instructions and requirements. I want to let you know that my educational background, proficiency, and experience merit me to handle this task and produce A+ work.
        I will love to work for you in this task.
      Thanks"
    end

    def past_body
      'Hello. I think we have already worked together. I can also do this task. Please reply me to have a deal. Thanks :)'
    end

    def price(value)
      assignment.price - value.to_f if assignment.price > 0
      value
    end
end
