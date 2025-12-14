# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require 'json'

# Cargar configuración de base de datos
require_relative 'config/database'

# Cargar modelos
require_relative 'lib/models/task'

# Cargar rutas
require_relative 'lib/routes/tasks'

# Aplicación principal
class TasksAPI < Sinatra::Base
  # Configuración
  configure do
    set :show_exceptions, false
    set :raise_errors, false
  end

  configure :development do
    set :show_exceptions, :after_handler
  end

  # Helpers
  helpers Sinatra::JSON

  # Incluir rutas
  register Routes::Tasks

  # Ruta raíz
  get '/' do
    json(
      name: 'Tasks API',
      version: '1.0.0',
      endpoints: {
        tasks: '/api/v1/tasks'
      }
    )
  end

  # Health check
  get '/health' do
    json(status: 'ok', timestamp: Time.now.iso8601)
  end

  # Manejo de errores
  error JSON::ParserError do
    status 400
    json(error: 'Invalid JSON')
  end

  error Sequel::ValidationFailed do |e|
    status 400
    json(error: e.message)
  end

  not_found do
    json(error: 'Not found')
  end

  error do
    status 500
    json(error: 'Internal server error')
  end
end

# Ejecutar si se llama directamente
if __FILE__ == $PROGRAM_NAME
  TasksAPI.run! port: ENV.fetch('PORT', 4567)
end
