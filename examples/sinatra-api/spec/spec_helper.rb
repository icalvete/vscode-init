# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

# Cargar SimpleCov antes de todo
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_group 'Models', 'lib/models'
    add_group 'Routes', 'lib/routes'
  end
end

require 'rack/test'
require 'rspec'
require 'json'

# Cargar configuración de base de datos primero
require_relative '../config/database'

# Ejecutar migraciones en memoria ANTES de cargar modelos
Sequel.extension :migration
Sequel::Migrator.run(DB, 'db/migrations')

# Cargar la aplicación (modelos y rutas)
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Definir la app para Rack::Test
  def app
    TasksAPI
  end

  # Helper para parsear JSON
  def json_response
    JSON.parse(last_response.body)
  end

  # Limpiar base de datos antes de cada test
  config.before(:each) do
    DB[:tasks].delete
  end

  # Configuración de RSpec
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed
end
