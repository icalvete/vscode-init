# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:tasks) do
      primary_key :id
      String :title, null: false, size: 255
      Text :description
      TrueClass :completed, default: false
      Integer :priority, default: 3
      Date :due_date
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
