# frozen_string_literal: true

require 'json'

# Modelo Task
# Representa una tarea en el sistema
class Task < Sequel::Model
  # Serialización de tags (almacenado como JSON string)
  def tags
    JSON.parse(super || '[]')
  end

  def tags=(value)
    super(value.is_a?(Array) ? value.to_json : value)
  end

  # Validaciones
  def validate
    super
    validates_presence :title
    validates_max_length 255, :title
    validates_includes 1..5, :priority if priority
    validate_tags
  end

  def validate_tags
    return unless self[:tags]

    parsed = JSON.parse(self[:tags]) rescue nil
    unless parsed.is_a?(Array) && parsed.all? { |t| t.is_a?(String) }
      errors.add(:tags, 'must be an array of strings')
    end
  end

  # Callbacks
  def before_create
    self.completed ||= false
    self.priority ||= 3
    super
  end

  # Métodos de instancia

  # Marca la tarea como completada
  # @return [Task] la tarea actualizada
  def complete!
    update(completed: true)
  end

  # Marca la tarea como pendiente
  # @return [Task] la tarea actualizada
  def uncomplete!
    update(completed: false)
  end

  # Verifica si la tarea está vencida
  # @return [Boolean]
  def overdue?
    return false unless due_date

    !completed && due_date < Date.today
  end

  # Serialización a JSON
  # @return [Hash]
  def to_json_hash
    {
      id: id,
      title: title,
      description: description,
      completed: completed,
      priority: priority,
      due_date: due_date&.iso8601,
      tags: tags,
      overdue: overdue?,
      created_at: created_at&.iso8601,
      updated_at: updated_at&.iso8601
    }
  end

  # Dataset methods (scopes)
  dataset_module do
    # Tareas completadas
    def completed
      where(completed: true)
    end

    # Tareas pendientes
    def pending
      where(completed: false)
    end

    # Filtrar por prioridad
    def by_priority(priority)
      where(priority: priority)
    end

    # Tareas de alta prioridad (1-2)
    def high_priority
      where { priority <= 2 }
    end

    # Tareas vencidas
    def overdue
      pending.where { due_date < Date.today }
    end

    # Ordenar por prioridad (alta primero)
    def by_priority_order
      order(:priority)
    end

    # Ordenar por fecha de vencimiento
    def by_due_date
      order(:due_date)
    end

    # Filtrar por tag
    def by_tag(tag)
      where(Sequel.lit("tags LIKE ?", "%\"#{tag}\"%"))
    end
  end
end
