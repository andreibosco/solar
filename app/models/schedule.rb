class Schedule < ActiveRecord::Base

  has_many :discussions
  has_many :lessons
  has_many :schedule_events
  has_many :portfolios
  has_many :assignments

  validates :start_date, :end_date, :presence => true
  validate :start_date_before_end_date 

  before_destroy :can_destroy?
  
  ## Validação que verifica se a data inicial é anterior à data final
  def start_date_before_end_date
    unless start_date.nil? or end_date.nil?
      errors.add(:start_date, I18n.t(:range_date_error, :scope => [:discussion, :errors])) if (start_date > end_date)
    end
  end

  ## Verifica se pode deletar o schedule: permite apenas se não tiver dependências
  def can_destroy?
    return false if not(discussions.empty? and lessons.empty? and assignments.empty? and schedule_events.empty?)
  end

  def self.events(allocation_tags, period = false, date_search = nil)
    where, where_hash = [], {}
    unless allocation_tags.nil?
      where_hash[:allocation_tags] = allocation_tags
      where << "allocation_tags.id IN (:allocation_tags)"
    end
    unless date_search.nil?
      where_hash[:date_search] = date_search.to_s(:db)
      where << "schedules.start_date = :date_search OR schedules.end_date = :date_search"
    end

    where = [where.join(' AND '), where_hash]

    schedules_events   = ScheduleEvent.joins(:schedule, :allocation_tag).where(where).select("'schedule_events' AS schedule_type, schedule_events.title AS name, schedule_events.description, schedules.start_date, schedules.end_date")
    assignments_events = Assignment.joins(:schedule, :allocation_tag).where(where).select("'assignments' AS schedule_type, assignments.name AS name, assignments.enunciation AS description, schedules.start_date, schedules.end_date")
    discussions_events = Discussion.joins(:schedule, :allocation_tag).where(where).select("'discussions' AS schedule_type, discussions.name AS name, discussions.description, schedules.start_date, schedules.end_date")
    lessons_events     = Lesson.joins(:schedule, :allocation_tag).where(where).select("'lessons' AS schedule_type, lessons.name AS name, lessons.description, schedules.start_date, schedules.end_date")
    events             = [schedules_events + assignments_events + discussions_events + lessons_events].flatten.compact.map(&:attributes).sort_by {|e| e['end_date'] }

    return events.slice(0,2) if period # apenas os dois primeiros
    return events
  end

end
