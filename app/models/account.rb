# -*- coding: utf-8 -*-
module Models
  class Account
    def self.get_saml_settings
      idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
      settings = idp_metadata_parser.parse_remote("http://saml-staging.elasticbeanstalk.com/saml2-metadata-idp-2.xml")

      settings.assertion_consumer_service_url = "http://saml-staging.elasticbeanstalk.com/saml/artifact"
      settings.issuer                         = "http://saml-staging.elasticbeanstalk.com/saml/metadata"
      settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
      settings.authn_context                  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

      # SSOと同時に属性取得のために以下の設定を追加する
      settings.attributes_index = 2
      settings.attribute_consuming_service.configure do
        service_name "Attribute"
        service_index 2
        add_attribute :name => "unification_id"
        add_attribute :name => "last_name"
      end

      settings
    end
  end
end
