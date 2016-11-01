Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '017650fd3048c8fe3aac', '251f66210ae7ec2e092053f8967b81fb16413fa8'
end
