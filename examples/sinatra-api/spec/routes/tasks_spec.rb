# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Tasks API' do
  describe 'GET /api/v1/tasks' do
    it 'returns empty array when no tasks' do
      get '/api/v1/tasks'

      expect(last_response.status).to eq(200)
      expect(json_response['data']).to eq([])
    end

    it 'returns all tasks' do
      Task.create(title: 'Task 1')
      Task.create(title: 'Task 2')

      get '/api/v1/tasks'

      expect(last_response.status).to eq(200)
      expect(json_response['data'].length).to eq(2)
    end

    it 'filters by completed status' do
      Task.create(title: 'Pending', completed: false)
      Task.create(title: 'Done', completed: true)

      get '/api/v1/tasks', completed: 'true'

      expect(json_response['data'].length).to eq(1)
      expect(json_response['data'][0]['title']).to eq('Done')
    end

    it 'filters by priority' do
      Task.create(title: 'Low', priority: 5)
      Task.create(title: 'High', priority: 1)

      get '/api/v1/tasks', priority: '1'

      expect(json_response['data'].length).to eq(1)
      expect(json_response['data'][0]['title']).to eq('High')
    end
  end

  describe 'GET /api/v1/tasks/:id' do
    it 'returns a task' do
      task = Task.create(title: 'My Task', priority: 2)

      get "/api/v1/tasks/#{task.id}"

      expect(last_response.status).to eq(200)
      expect(json_response['data']['title']).to eq('My Task')
      expect(json_response['data']['priority']).to eq(2)
    end

    it 'returns 404 for non-existent task' do
      get '/api/v1/tasks/999'

      expect(last_response.status).to eq(404)
      expect(json_response['error']).to eq('Task not found')
    end
  end

  describe 'POST /api/v1/tasks' do
    it 'creates a task' do
      post '/api/v1/tasks',
           { title: 'New Task', priority: 2 }.to_json,
           'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(201)
      expect(json_response['data']['title']).to eq('New Task')
      expect(json_response['data']['priority']).to eq(2)
      expect(json_response['data']['completed']).to eq(false)
    end

    it 'creates a task with default priority' do
      post '/api/v1/tasks',
           { title: 'New Task' }.to_json,
           'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(201)
      expect(json_response['data']['priority']).to eq(3)
    end

    it 'returns error for missing title' do
      post '/api/v1/tasks',
           { priority: 2 }.to_json,
           'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(400)
    end

    it 'returns error for invalid priority' do
      post '/api/v1/tasks',
           { title: 'Task', priority: 10 }.to_json,
           'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(400)
    end
  end

  describe 'PUT /api/v1/tasks/:id' do
    it 'updates a task' do
      task = Task.create(title: 'Old Title')

      put "/api/v1/tasks/#{task.id}",
          { title: 'New Title' }.to_json,
          'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(200)
      expect(json_response['data']['title']).to eq('New Title')
    end

    it 'returns 404 for non-existent task' do
      put '/api/v1/tasks/999',
          { title: 'New Title' }.to_json,
          'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(404)
    end
  end

  describe 'DELETE /api/v1/tasks/:id' do
    it 'deletes a task' do
      task = Task.create(title: 'To Delete')

      delete "/api/v1/tasks/#{task.id}"

      expect(last_response.status).to eq(204)
      expect(Task[task.id]).to be_nil
    end

    it 'returns 404 for non-existent task' do
      delete '/api/v1/tasks/999'

      expect(last_response.status).to eq(404)
    end
  end

  describe 'PATCH /api/v1/tasks/:id/complete' do
    it 'marks a task as completed' do
      task = Task.create(title: 'Task', completed: false)

      patch "/api/v1/tasks/#{task.id}/complete"

      expect(last_response.status).to eq(200)
      expect(json_response['data']['completed']).to eq(true)
    end
  end

  describe 'PATCH /api/v1/tasks/:id/uncomplete' do
    it 'marks a task as pending' do
      task = Task.create(title: 'Task', completed: true)

      patch "/api/v1/tasks/#{task.id}/uncomplete"

      expect(last_response.status).to eq(200)
      expect(json_response['data']['completed']).to eq(false)
    end
  end
end
