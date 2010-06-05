# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Setlist_session',
  :secret      => 'aaa6a986b8c30d4ede97935e9d430f98ebdf44f5c2c0f2a4663324cb54e3c537270bca1f96c2a12c58f479b3ab2ab69d9a5f97fabf5d74edd8b17d91d129b4cd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
