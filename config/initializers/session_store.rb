# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: '_hwf-publicapp_session',
                                       secure: Rails.env.production?,
                                       domain: if Rails.env.production?
                                                 '.helpwithcourtfees.service.gov.uk'
                                               else
                                                 '.hmcts.net'
                                               end,
                                       same_site: :strict
