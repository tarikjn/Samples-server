class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :facebook_token, :first_name, :last_name, :gender, :birthday, :facebook_friends_count

  validates :gender, :inclusion => {:in => %w(male female)}
  # TODO: add fb_token update time

  def name
    first_name + ' ' + last_name
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def self.create_from_facebook_response(facebook_access_token, facebook_response)
    # count the user's friends, TODO: thread it?
    friends_response = Facebook.new(facebook_access_token).get("/me/friends")
    raise "new user friends_response issue" unless friends_response.code == 200

    # create new class instance and return it
    self.new(
      facebook_id: facebook_response['id'],
      facebook_token: facebook_access_token,
      email: facebook_response['email'],
      first_name: facebook_response['first_name'],
      last_name: facebook_response['last_name'],
      gender: facebook_response['gender'],
      birthday: Date.strptime(facebook_response['birthday'], '%m/%d/%Y'),
      facebook_friends_count: friends_response['data'].count
    )
  end
end
