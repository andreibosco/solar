require 'active_support/concern'

module Taggable
  extend ActiveSupport::Concern

  included do
    before_destroy :destroy_empty_modules # modulos vazios (default)
    before_destroy :can_destroy?

    after_create :allocation_tag_association
    after_create :allocate_profiles

    has_one :allocation_tag, dependent: :destroy

    has_many :allocations, through: :allocation_tag
    has_many :users,       through: :allocation_tag

    attr_accessor :user_id
  end

  ## verificando destroy
  def destroy_empty_modules
    return unless respond_to?(:lesson_modules)

    # modules without lessons
    lm_ids = lesson_modules.pluck(:id)
    lm_lessons = Lesson.where(lesson_module_id: lm_ids).pluck(:id).flatten

    if lm_lessons.empty?
      lesson_modules.map(&:academic_allocations).flatten.map(&:delete) # usando delete para nao chamar callbacks
      lesson_modules.map(&:delete)
    end
  end

  def can_destroy?
    errors.add(:base, I18n.t(:dont_destroy_with_lower_associations)) if has_any_lower_association?
    errors.add(:base, I18n.t(:dont_destroy_with_many_allocations)) if allocations.count > 1 # se possuir mais de um usuario alocado, nao deleta

    alc = academic_allocations.count
    if alc > 0 # tem conteudo
      # pode destruir somente se o conteudo for apenas um modulo de aula
      errors.add(:base, I18n.t(:dont_destroy_with_content)) unless alc == 1 and not(academic_allocations.where(academic_tool_type: 'LessonModule').empty?)
    end

    return errors.empty?
  end

  ## demais metodos

  def unallocate_user(user_id, profile_id = nil)
    query = {user_id: user_id}
    query.merge!({profile_id: profile_id}) unless profile_id.nil?

    allocations.where(query).destroy_all
  end

  def allocation_tag_association
    AllocationTag.create({self.class.name.underscore.to_sym => self})
  end

  # creates or activates user allocation
  def allocate_user(user_id, profile_id)
    allocation = Allocation.where(user_id: user_id, allocation_tag_id: self.allocation_tag.id, profile_id: profile_id).first_or_initialize
    allocation.status = Allocation_Activated
    allocation.save
    allocation
  end

  ## criacao de lesson module default :: devera ser chamada apenas por groups e offers
  def create_default_lesson_module(name)
    LessonModule.transaction do
      lm = LessonModule.create(name: name, is_default: true)
      lm.academic_allocations.create(allocation_tag: allocation_tag)
    end if respond_to?(:lesson_modules)
  end

  ###
  ## Alocações
  ###

  ## user_id, new_status, opts = {profile_id, related}
  def change_allocation_status(user_id, new_status, opts = {})
    where = {user_id: user_id}
    where.merge!({profile_id: opts[:profile_id]}) if opts.include?(:profile_id) and not opts[:profile_id].nil?

    all = if opts.include?(:related) and opts[:related]
      Allocation.where(allocation_tag_id: allocation_tag.related({lower: true})).where(where)
    else
      allocations.where(where)
    end

    all.update_all(status: new_status)
  end

  ## desabilitar todas as alocacoes do usuario nesta ferramenta academica
  def disable_user_allocations(user_id)
    change_allocation_status(user_id, Allocation_Cancelled)
  end

  ## desabilitar todas as alocacoes do usuario para o perfil informado nesta ferramenta academica
  def disable_user_profile_allocation(user_id, profile_id)
    change_allocation_status(user_id, Allocation_Cancelled, {profile_id: profile_id})
  end

  ## desabilitar todas as alocacoes do usuario nesta ferramenta academica e nas ferramentas academicas abaixo desta (ex: offers -> groups)
  def disable_user_allocations_in_related(user_id)
    change_allocation_status(user_id, Allocation_Cancelled, {related: true})
  end

  ## desabilitar todas as alocacoes do usuario para o perfil informado nesta ferramenta academica e nas ferramentas academicas abaixo desta (ex: offers -> groups)
  def disable_user_profile_allocations_in_related(user_id, profile_id)
    change_allocation_status(user_id, Allocation_Cancelled, {profile_id: profile_id, related: true})
  end

  ## ativar alocacao do usuario nesta ferramenta academica
  def enable_user_allocations(user_id)
    change_allocation_status(user_id, Allocation_Activated)
  end

  ## ativar alocacao do usuario nesta ferramenta academica e nas ferramentas academicas abaixo desta (ex: offers -> groups)
  def enable_user_allocations_in_related(user_id)
    change_allocation_status(user_id, Allocation_Activated, {related: true})
  end

  ## ativar alocacao do usuario para o perfil informado nesta ferramenta academica
  def enable_user_profile_allocation(user_id, profile_id)
    change_allocation_status(user_id, Allocation_Activated, {profile_id: profile_id})
  end

  ## ativar alocacao do usuario para o perfil informado nesta ferramenta academica e nas ferramentas academicas abaixo desta (ex: offers -> groups)
  def enable_user_profile_allocations_in_related(user_id, profile_id)
    change_allocation_status(user_id, Allocation_Activated, {profile_id: profile_id, related: true})
  end

  ########

  def info(args = {})
    params = {separator: '-', include_type: false}.merge(args)
    except = params[:include_type] ? nil : :curriculum_unit_type

    detailed_info.except(except).values.uniq.join " #{params[:separator]} "
  end

  ## Após criar algum elemento taggable (uc, curso, turma, oferta), verifica todos os perfis que o usuário possui
  ## e, para cada um daqueles que possuem permissão de realizar a ação previamente realizada, é criada uma alocação
  def allocate_profiles
    return unless user_id

    controller_name = self.class.name.underscore << 's'
    profiles_with_access = User.find(user_id).profiles.joins(:resources).where(resources: {action: 'create', controller: controller_name}).pluck(:id)

    profiles_with_access.each do |profile|
      allocate_user(user_id, profile)
    end
  end

end
