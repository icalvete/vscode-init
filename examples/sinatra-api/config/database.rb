# frozen_string_literal: true

require 'sequel'

# Configuración de base de datos según entorno
DB = case ENV.fetch('RACK_ENV', 'development')
     when 'test'
       Sequel.sqlite # Base de datos en memoria para tests
     when 'production'
       Sequel.connect(ENV.fetch('DATABASE_URL'))
     else
       Sequel.sqlite('db/development.sqlite3')
     end

# Extensiones de Sequel
DB.extension :pagination
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :validation_helpers
