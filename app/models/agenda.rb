class Agenda < ActiveRecord::Base

  def self.events(allocation_tags, period = false, date_search = nil)
    where_date = []
    where_date = ["(schedules.start_date = :date_search OR schedules.end_date = :date_search)", {date_search: date_search.to_s(:db)}] unless date_search.nil?

    assignments_events = Assignment.joins(:schedule, :academic_allocations).where(academic_allocations: {allocation_tag_id: allocation_tags}).where(where_date).select("'assignments' AS schedule_type, assignments.name AS name, assignments.enunciation AS description, schedules.start_date, schedules.end_date")
    discussions_events = Discussion.joins(:schedule, :academic_allocations).where(academic_allocations: {allocation_tag_id: allocation_tags}).where(where_date).select("'discussions' AS schedule_type, discussions.name AS name, discussions.description, schedules.start_date, schedules.end_date")
    lessons_events     = Lesson.joins(:schedule, {lesson_module: :academic_allocations}).where(academic_allocations: {allocation_tag_id: allocation_tags}).where(where_date).select("'lesson' AS schedule_type, lessons.name AS name, lessons.description, schedules.start_date, schedules.end_date")
    schedules_events   = ScheduleEvent.joins(:schedule, :academic_allocations).where(academic_allocations: {allocation_tag_id: allocation_tags}).where(where_date).select("'schedule_events' AS schedule_type, schedule_events.title AS name, schedule_events.description, schedules.start_date, schedules.end_date")

    events = [schedules_events + assignments_events + discussions_events + lessons_events].flatten.compact.map(&:attributes).sort_by {|e| e['end_date'] || e['start_date'] }

    events
  end

  def self.events_detailed(allocation_tags, period = false, date_search = nil)
    e = events(allocation_tags, period, date_search)
    e.collect { |schedule_event|
      schedule_end_date = schedule_event['end_date'].nil? ? "" : schedule_event['end_date'].to_date
      [schedule_event['start_date'].to_date, schedule_end_date]
    }.flatten.uniq
  end

end
