# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: '_hwf-publicapp_session',
                                       domain: Rails.env.production? ? '.hmcts.net' : nil,
                                       same_site: :strict
