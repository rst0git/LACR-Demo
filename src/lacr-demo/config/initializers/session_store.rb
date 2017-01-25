# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, servers: "redis://redis:6379/0/session", key: '_lacr-demo_session' 
