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

=begin
EventMailer.subscription(@event, @new_subscription).deliver_now



notify_about_photo(@event, @new_photo)

def notify_about_photo(event, photo)
  all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user&.email]).uniq

  all_emails.each do |mail|
    EventMailer.photo(event, photo, mail).deliver_now
  end
end

notify_subscribers(@event, @new_comment)

def notify_subscribers(event, comment)
  all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user&.email]).uniq

  all_emails.each do |mail|
    EventMailer.comment(event, comment, mail).deliver_now
  end
end
=end
