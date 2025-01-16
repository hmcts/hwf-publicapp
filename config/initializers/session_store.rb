# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: '_hwf-publicapp_session',
                                       secure: Rails.env.production?,
                                       same_site: :strict,
                                       domain: if Rails.env.production?
                                                 %w[.helpwithcourtfees.service.gov.uk
                                                    .hmcts.net]
                                               end
