module PasswordGenerator
                                                     
  # alphanumerics, minus easily-confused characters
  ALLOWED_CHARACTERS = ("A".."Z").to_a + ("a".."z").to_a + ("0".."9").to_a - [ '0', '1', 'l', 'I', 'o', 'O' ]
  
  def random_password(length)
    Array.new(length) { ALLOWED_CHARACTERS.rand }.join
  end
  
end