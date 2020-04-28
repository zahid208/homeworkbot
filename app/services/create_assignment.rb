class CreateAssignment
  attr_reader :li
  attr_reader :assignment
  attr_reader :account

  def self.call(li, account)
    self.new(li, account).call
  end

  def initialize (li, account)
    @li = li
    @account = account
    @assignment= account.assignments.find_or_initialize_by(slug: slug)
  end

  def call
    assignment.attributes = { title: title, body: body, price: price, link: link, field: field, account: account }
    assignment.save
    assignment
  end

  private
    def link
      (li.find('h3 a')[:href])
    end

    def slug
      link.split('/')[-1]
    end

    def title
      li.find('h3 a').text
    end

    def body
      li.all('.content-part .break-words p').collect(&:text).join " "
    end

    def price
      li.find('.header-rt .text-large').text.gsub("$", "").strip.to_f
    end

    def field
      li.all('.col .dd').first.text
    end
end
