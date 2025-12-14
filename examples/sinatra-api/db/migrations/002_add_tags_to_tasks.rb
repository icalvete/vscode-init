# frozen_string_literal: true

Sequel.migration do
  change do
    add_column :tasks, :tags, :text, default: '[]'
  end
end
