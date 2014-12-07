# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
CiscoRailsApi2::Application.config.secret_token = 'dc18862f21f6b3e7cbb0a0e0c0ebb3315fffb7ee5034453d0a2763fc1a1a56d31fe77b5bab1a871afd97071b4630e809b9ecba8f0b1c00f19730a14ac76d3dfb'
