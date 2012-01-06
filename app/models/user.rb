class User < ActiveRecord::Base

  has_many :allocations
  has_many :lessons
  has_many :discussion_posts
  has_many :user_messages
  has_many :user_contacts, :class_name => "UserContact", :foreign_key => "user_id"
  has_many :user_contacts, :class_name => "UserContact", :foreign_key => "user_related_id"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable, :trackable
  devise :database_authenticatable, :registerable, :validatable,
    :recoverable, :encryptable, :token_authenticatable # autenticacao por token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :alternate_email, :password, :password_confirmation, :remember_me, :name, :nick, :birthdate,
    :address, :address_number, :address_complement, :address_neighborhood, :zipcode, :country, :state, :city,
    :telephone, :cell_phone, :institution, :gender, :cpf, :bio, :interests, :music, :movies, :books, :phrase, :site, :photo

  validates :username, :length => { :within => 3..20 }, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :confirmation => true
  validates :alternate_email, :format => { :with => %r{^((?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4}))?$}i}

  validates :nick, :length => { :within => 3..34 }
  validates :name, :length => { :within => 6..90 }
  validates :birthdate, :presence => true
  validates :cpf, :presence => true, :uniqueness => true

  validates_length_of :address, :maximum => 99
  validates_length_of :address_neighborhood, :maximum => 49
  validates_length_of :zipcode, :maximum => 9
  validates_length_of :country,:maximum => 90
  validates_length_of :city, :maximum => 90
  validates_length_of :institution, :maximum => 120
  validate :cpf_ok

  # paperclip uses: file_name, content_type, file_size e updated_at
  # Configuração do paperclip para upload de fotos
  has_attached_file :photo,
    :styles => { :medium => "72x90#", :small => "25x30#", :forum => "40x40#" },
    :path => ":rails_root/media/:class/:id/photos/:style.:extension",
    :url => "/media/:class/:id/photos/:style.:extension",
    :default_url => "/images/no_image.png"

  # path and URL define that images will be in "public/images/"
  # and will be created a folder called "users" with object id (eg users/1)
  # default_url define default image (if image is dropped or not exists)

  # validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 700.kilobyte, :message => " " # Esse :message => " " deve permanecer dessa forma enquanto não descobrirmos como passar a mensagem de forma correta. Se o message for vazio a validação não é feita.
  validates_attachment_content_type :photo,
    :content_type => ['image/jpeg','image/png','image/gif','image/pjpeg'],
    :message => :invalid_type

  def cpf_ok
    cpf_verify = Cpf.new(self[:cpf])
    errors.add(:cpf, I18n.t(:new_user_msg_cpf_error)) unless cpf_verify.valido? unless cpf_verify.nil?
  end

  # Alocar usuario para acesso com o perfil básico no ato da sua criação
  def after_create
    new_allocation_user = Allocation.new :profile_id => Rails.application.config.profile, :status => Allocation_Activated, :user_id => self.id
    new_allocation_user.save!
  end

end