class SupportMaterialFileEditorController < ApplicationController

  #  def list
  #
  #    authorize! :list, Portfolio
  #
  #    group_id = session[:opened_tabs][session[:active_tab]]["groups_id"]
  #
  #    # listando atividades individuais pelo grupo_id em que o usuario esta inserido
  #    @individual_activities = Portfolio.individual_activities(group_id, current_user.id)
  #
  #    # area publica
  #    @public_area = Portfolio.public_area(group_id, current_user.id)
  #
  #  end

  def list
    @offers  = ""
    @groups  = ""

  end

  def upload_link
    url  = params[:link]["link"]
    allocation_tag_id = 3
    @newlink = SupportMaterialFile.upload_link(allocation_tag_id, url)

    flash[:notice] = "Link enviado com sucesso !"
    redirect_to :controller => "support_material_file_editor", :action => "list"
    
  end

  def upload_files
    #### PEGAR ALLOCATION TAG ! ! !
    allocation_tag_id = 3
    authorize! :upload_files, SupportMaterialFileEditor

    respond_to do |format|
      begin
        # redireciona para a lista
        redirect = {:action => :list}

        # verifica se o arquivo foi adicionado
        raise t(:error_no_file_sent) unless params.include?(:support_material)

        # allocation_tag do grupo selecionada
        #        allocation_tag_id = AllocationTag.find(:first, :conditions => ["group_id = ?", session[:opened_tabs][session[:active_tab]]["groups_id"]]).id


        @file = SupportMaterialFile.new params[:support_material]
        @file.allocation_tag_id = allocation_tag_id
        @file.save!

        # arquivo salvo com sucesso
        flash[:success] = t(:file_uploaded)
        format.html { redirect_to(redirect) }

      rescue Exception => error

        flash[:error] = error.message
        format.html { redirect_to(redirect) }

      end
    end
  end


  def create_folder
    new_folder = params[:folder]["new_folder"]
  end


  def delete_select_files
    
  end


end