class ChatRoom < ActiveRecord::Base
  
  GROUP_PERMISSION = true

  has_many :messages, class_name: "ChatMessage"
  has_many :participants, class_name: "ChatParticipant", dependent: :destroy
  has_many :academic_allocations, as: :academic_tool
  has_many :allocation_tags, through: :academic_allocations
  has_many :groups, through: :allocation_tags

  has_many :users, through: :participants
  has_many :allocations, through: :participants

  belongs_to :schedule

  accepts_nested_attributes_for :schedule

  validates :title, :start_hour, :end_hour, presence: true

  validates_format_of :start_hour, :end_hour, with: /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/

  validate :verify_hours, unless: Proc.new { |a| a.start_hour.blank? or a.end_hour.blank?}

  accepts_nested_attributes_for :participants, allow_destroy: true, reject_if: proc { |attributes| attributes['allocation_id'] == "0" }

  attr_accessible :participants_attributes, :title, :start_hour, :end_hour, :description, :schedule_attributes, :chat_type, :schedule_id

  before_destroy :can_destroy?
  after_destroy :delete_schedule

  def verify_hours
    errors.add(:end_hour, I18n.t(:range_hour_error, scope: [:chat_rooms, :error])) if end_hour.rjust(5, '0') < start_hour.rjust(5, '0')
  end

  def delete_schedule
    self.schedule.destroy
  end

  def can_destroy?
    self.messages.empty?
  end

  def copy_dependencies_from(chat_to_copy)
    ChatParticipant.create! chat_to_copy.participants.map {|participant| participant.attributes.merge({chat_room_id: self.id})} unless chat_to_copy.participants.empty?
  end

  def can_remove_or_unbind_group?(group)
    self.messages.empty? # não pode dar unbind nem remover se chat possuir mensagens
  end

  def opened?
    self.schedule.start_date.to_date <= Date.today and schedule.end_date.to_date >= Date.today
  end

  def self.chats_user(allocation_tags_ids, user_id)
    ChatRoom.joins(:academic_allocations, :allocation_tags, :participants, :users, :schedule)
      .where(allocation_tags: {id: allocation_tags_ids}).where(users: {id: user_id}).uniq
      #.order("start_date")
  end

  def self.chats_other_users(allocation_tags_ids, user_id)
    # *** MUDAR
    ChatRoom.joins(:academic_allocations, :allocation_tags, :participants, :users, :schedule)
      .where(allocation_tags: {id: allocation_tags_ids}).where(users: {id: user_id}).uniq
  end

end
