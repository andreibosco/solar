class GroupAssignmentsController < ApplicationController

	include GroupAssignmentHelper

  before_filter :prepare_for_group_selection#, :only => [:list]

  # lista trabalhos em grupo
  def list
    #authorize! :list, Portfolio

    # group_id = AllocationTag.find(active_tab[:url]['allocation_tag_id']).group_id
    group_id = AllocationTag.find(params[:id]).group_id

    #traz apenas os trabalhos de grupo dessa turma
    @assignments = GroupAssignment.all_by_group_id(group_id)
  end

  ##
  # Novo grupo
  # @groups: todos os grupos da atividade
  # @students_with_no_group: lista de alunos sem grupo
  # @students_of_class: lista com todos os alunos da turma
  ##
  def new
    @group_assignment = GroupAssignment.new(params[:group_assignment])
    @assignment = Assignment.find(params[:id])
    @groups = group_assignments(@assignment.id)
    @studens_with_no_group = no_group_students(@assignment.id)
    @students_of_class = all_students(@assignment.id)
  end

  ##
  # Cria o grupo
  ##
  def create
    new_group_assignment = GroupAssignment.new(:assignment_id => params[:assignment_id], :group_name => params[:group_assignment][:group_name])
    if new_group_assignment.save
      change_students_group(new_group_assignment)
      flash[:notice] = t(:group_assignment_success)
      redirect_to :action => :list, :id => 3
    else
      flash[:alert] = new_group_assignment.errors.full_messages[0]
      redirect_to :action => :new, :id => params[:assignment_id]
    end
  end

  ##
  # Edição de grupo
  # @groups: todos os grupos da atividade
  # @students_with_no_group: lista de alunos sem grupo
  # @students_of_class: lista com todos os alunos da turma
  ##
  def edit
    @group_assignment = GroupAssignment.find(params[:id])
    @groups = group_assignments(@group_assignment.assignment_id)
    @studens_with_no_group = no_group_students(@group_assignment.assignment_id)
    @students_of_class = all_students(@group_assignment.assignment_id)
  end

  ##
  # Edita o grupo
  ##
  def update
    group_assignment = GroupAssignment.find(params[:group_assignment_id])
    if group_assignment.update_attributes(params[:group_assignment])
      change_students_group(group_assignment)
      flash[:notice] = t(:group_assignment_success)
      redirect_to :action => :list, :id => 3
    else
      flash[:alert] = group_assignment.errors.full_messages[0]
      redirect_to :action => :edit, :id => group_assignment.id
    end
  end

  ##
  # Exclui o grupo
  ##
  def destroy
    group_assignment = GroupAssignment.find(params[:id])
    if SendAssignment.find_all_by_group_assignment_id(group_assignment.id).empty?
      participants = group_participants(group_assignment.id)
      participants.each{|participant| GroupParticipant.find(participant["id"]).delete}
      GroupAssignment.find(group_assignment.id).delete
      flash[:notice] = t(:group_assignment_delete_success)
      redirect_to :action => :new, :id => group_assignment.assignment_id
    else
      flash[:alert] = t(:group_assignment_delete_error)
      redirect_to :action => :edit, :id => group_assignment.id
    end
  end

private
  ##
  # Método que realiza as mudanças de um grupo e realiza as trocas de alunos
  # => group_assingment: objeto do grupo_assignment a ser alterado/criado
  ##
  def change_students_group(group_assignment)
    @groups = group_assignments(group_assignment.assignment_id)
    @studens_with_no_group = no_group_students(group_assignment.assignment_id)
    group_assignment.group_name = params[:group_assignment][:group_name]
      for group in @groups
        gp = group_participants(group["id"])
        for p in gp
          # se o participante em questão tiver sido selecionado
          if !params[:students].nil? and params[:students].include?(p["user_id"])
            # troca seu grupo
            participant = GroupParticipant.find(p["id"])
            participant.update_attribute(:group_assignment_id, group_assignment.id)
          end
          # se o grupo do participante em questão for o grupo que foi alterado E (nenhum aluno tiver sido selecionado OU o participante em questão não estiver incluso na lista de alunos) E o participante em questão não tiver enviado nenhum arquivo pelo grupo
          # remove o aluno do grupo
          GroupParticipant.find(p["id"]).delete if p["group_assignment_id"].to_i == group_assignment.id and (params[:students].nil? or !params[:students].include?(p["user_id"])) and SendAssignment.find_all_by_group_assignment_id_and_user_id(group_assignment.id, p["user_id"].to_i).empty?
        end
      end
      for no_group in @studens_with_no_group
        # associa
        GroupParticipant.create(:group_assignment_id => group_assignment.id, :user_id => no_group.id) if !params[:students].nil? and params[:students].include?(no_group.id.to_s)
      end
  end

end