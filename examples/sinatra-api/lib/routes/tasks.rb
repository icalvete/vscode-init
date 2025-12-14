# frozen_string_literal: true

module Routes
  # Rutas para gestión de tareas
  module Tasks
    def self.registered(app)
      # GET /api/v1/tasks - Lista todas las tareas
      app.get '/api/v1/tasks' do
        tasks = Task.dataset

        # Filtros opcionales
        tasks = tasks.completed if params[:completed] == 'true'
        tasks = tasks.pending if params[:completed] == 'false'
        tasks = tasks.by_priority(params[:priority].to_i) if params[:priority]
        tasks = tasks.overdue if params[:overdue] == 'true'
        tasks = tasks.by_tag(params[:tag]) if params[:tag]

        # Ordenamiento
        tasks = case params[:sort]
                when 'priority'
                  tasks.by_priority_order
                when 'due_date'
                  tasks.by_due_date
                else
                  tasks.order(Sequel.desc(:created_at))
                end

        json(data: tasks.all.map(&:to_json_hash))
      end

      # GET /api/v1/tasks/:id - Obtiene una tarea
      app.get '/api/v1/tasks/:id' do
        task = Task[params[:id]]
        halt 404, json(error: 'Task not found') unless task

        json(data: task.to_json_hash)
      end

      # POST /api/v1/tasks - Crea una tarea
      app.post '/api/v1/tasks' do
        data = JSON.parse(request.body.read)

        task = Task.create(
          title: data['title'],
          description: data['description'],
          priority: data['priority'],
          due_date: data['due_date'] ? Date.parse(data['due_date']) : nil,
          tags: data['tags'] || []
        )

        status 201
        json(data: task.to_json_hash)
      end

      # PUT /api/v1/tasks/:id - Actualiza una tarea
      app.put '/api/v1/tasks/:id' do
        task = Task[params[:id]]
        halt 404, json(error: 'Task not found') unless task

        data = JSON.parse(request.body.read)

        task.update(
          title: data['title'] || task.title,
          description: data.key?('description') ? data['description'] : task.description,
          priority: data['priority'] || task.priority,
          completed: data.key?('completed') ? data['completed'] : task.completed,
          due_date: data['due_date'] ? Date.parse(data['due_date']) : task.due_date,
          tags: data.key?('tags') ? data['tags'] : task.tags
        )

        json(data: task.to_json_hash)
      end

      # DELETE /api/v1/tasks/:id - Elimina una tarea
      app.delete '/api/v1/tasks/:id' do
        task = Task[params[:id]]
        halt 404, json(error: 'Task not found') unless task

        task.destroy

        status 204
      end

      # PATCH /api/v1/tasks/:id/complete - Marca como completada
      app.patch '/api/v1/tasks/:id/complete' do
        task = Task[params[:id]]
        halt 404, json(error: 'Task not found') unless task

        task.complete!

        json(data: task.to_json_hash)
      end

      # PATCH /api/v1/tasks/:id/uncomplete - Marca como pendiente
      app.patch '/api/v1/tasks/:id/uncomplete' do
        task = Task[params[:id]]
        halt 404, json(error: 'Task not found') unless task

        task.uncomplete!

        json(data: task.to_json_hash)
      end
    end
  end
end
