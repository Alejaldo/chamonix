class EmailsJob < ApplicationJob
  queue_as :default

  def perform(event, new_instance)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [new_instance.user&.email]).uniq

    case new_instance
    when Subscription
      EventMailer.subscription(event, new_instance).deliver_later
    when Comment
      all_emails.each do |mail|
        EventMailer.comment(event, new_instance, mail).deliver_later
      end
    when Photo
      all_emails.each do |mail|
        EventMailer.photo(event, new_instance, mail).deliver_later
      end
    end
  end
end
