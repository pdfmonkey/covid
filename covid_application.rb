# frozen_string_literal: true

begin
  RACK_ENV = ENV.fetch('RACK_ENV', 'development').to_sym

  require 'open-uri'

  require 'bundler/setup'
  Bundler.require(:default, RACK_ENV)

  require 'active_support/core_ext/string/inflections'
  require 'sinatra/content_for'
  require 'sinatra/reloader'

  class CovidApplication < Sinatra::Base
    ATTESTATION_TEMPLATE = ENV.fetch('ATTESTATION_TEMPLATE')
    ATTESTATION_PRO_TEMPLATE = ENV.fetch('ATTESTATION_PRO_TEMPLATE')

    configure :development do
      register Sinatra::Reloader
    end

    helpers Sinatra::ContentFor

    get '/' do
      erb :index
    end

    get '/attestation-deplacement' do
      erb :attestation_deplacement
    end

    get '/justificatif-deplacement-pro' do
      erb :justificatif_deplacement_pro
    end

    post '/attestation-deplacement' do
      send_pdf ATTESTATION_TEMPLATE, params
    end

    post '/justificatif-deplacement-pro' do
      send_pdf ATTESTATION_PRO_TEMPLATE, params
    end

    private def send_pdf(template_id, payload)
      document = Pdfmonkey::Document.generate!(template_id, payload)

      if document.status == 'success'
        send_file open(document.download_url),
          type: 'application/pdf',
          disposition: :attachment,
          filename: 'attestation.pdf'
      else
        "Désolé, une erreur est survenue lors de la génération du document."
      end
    end
  end
rescue => e
  $stderr.puts "ERROR: #{e.message}"
end
