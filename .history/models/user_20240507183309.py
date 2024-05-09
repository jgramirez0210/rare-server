class User():
  def __init__(self, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active):
    self.first_name = first_name  
    self.last_name = last_name
    self.email = email
    self.bio = bio
    self.username = username
    self.password = password
    self.profile_image_url = profile_image_url
    self.created_on = created_on
    self.active = active
    
class Serialized():
  def __init__(self, first_name, last_name, email, bio, username,  profile_image_url, created_on, active):
    self.first_name = first_name  
    self.last_name = last_name
    self.email = email
    self.bio = bio
    self.profile_image_url = profile_image_url
    self.created_on = created_on
    self.active = active   
