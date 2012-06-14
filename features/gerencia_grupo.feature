# language: pt
Funcionalidade: Exibir Página de Grupos de Portfolio
  Como um usuário do solar
  Eu quero listar os trabalhos de grupo disponíveis
  Para poder gerenciar os grupos de trabalho

Contexto:
    Dado que tenho "allocations"
        | user_id  | allocation_tag_id  | profile_id  | status |
        | 1        | 3                  | 3           | 1      |

Cenário: Exibir Tela de Cadastro de Trabalho de Grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
        E eu deverei ver "Atividade em grupo II"
        E eu nao deverei ver "Atividade I"
        E eu nao deverei ver "Atividade II"
        E eu nao deverei ver "Atividade III"

@javascript
Cenário: Exibir Grupos de Trabalho
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
        Então eu deverei ver "Atividade em grupo II"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
        E eu deverei ver "grupo2 tI"
        E eu deverei ver "grupo3 tI"
    Quando eu clicar no item "Atividade em grupo II"
        Então eu deverei ver "grupo1 - tII"
        E eu deverei ver "grupo2 - tII"

@javascript 
Cenário: Acessar página de cadastro de novo grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
        Então eu deverei ver "Atividade em grupo II"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
        E eu deverei ver "grupo2 tI"
        E eu deverei ver "grupo3 tI"
        E eu deverei ver o botao "Novo grupo"
    Quando eu clicar em "Novo grupo"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver "Aluno 1"
            E eu deverei ver "Aluno 2"
        E eu deverei ver "grupo2 tI"
            E eu deverei ver "Aluno 3"
            E eu deverei ver "Usuario do Sistema"
        E eu deverei ver "grupo3 tI"
            E eu deverei ver "Grupo sem participantes"
        E eu deverei ver "Novo grupo"    
            E eu deverei ver "Nome do grupo"
            E eu deverei ver "Alunos"

@javascript 
Cenário: Cadastro de novo grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        E eu deverei ver o botao "Novo grupo"
    Quando eu clicar em "Novo grupo"
        Dado que eu preenchi "group_assignment_group_name" com "grupo100 tI"
        Então eu deverei ver o botao "Salvar"
            E eu deverei ver o botao "Cancelar"
        Quando eu clicar em "Salvar"
            Então eu deverei estar em "Lista de atividades em grupo"
            E eu deverei ver "Grupo salvo com sucesso"

@javascript
Cenário: Cadastro de novo grupo com confirm Ok
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        E eu deverei ver o botao "Novo grupo"
    Quando eu clicar em "Novo grupo"
        Dado que eu preenchi "group_assignment_group_name" com "grupo100 tI"
            Então eu deverei ver "grupo2 tI"
            E eu deverei ver o link "edit_2"
        Quando eu clicar no link "edit_2"
            E eu clicar em "Ok" no popup
                Então eu deverei estar em "Edicao do grupo2 tI"
                E eu deverei ver "Grupo salvo com sucesso"
                E eu deverei ver "grupo100 tI"

@javascript
Cenário: Cadastro de novo grupo com confirm Cancel
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        E eu deverei ver o botao "Novo grupo"
    Quando eu clicar em "Novo grupo"
        Dado que eu preenchi "group_assignment_group_name" com "grupo100 tI"
            Então eu deverei ver "grupo2 tI"
            E eu deverei ver o link "edit_2"
        Quando eu clicar no link "edit_2"
            E eu clicar em "Cancelar" no popup
                Então eu deverei estar em "Edicao do grupo2 tI"
                E eu nao deverei ver "Grupo salvo com sucesso"
                E eu nao deverei ver "grupo100 tI"

@javascript
Cenário: Acessar página de edição de grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            Então eu deverei ver "Editar grupo"
                E eu deverei ver "Nome do grupo"
                E eu deverei ver "Alunos"

@javascript 
Cenário: Edição de grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Dado que eu preenchi "group_assignment_group_name" com "grupo1.2 tI"
            Então eu deverei ver os alunos do grupo com id "1" selecionados
        Quando eu clicar no grupo "2"
            Então eu deverei ver "Aluno 3"
                E eu deverei ver "Usuario do sistema"
            Quando eu selecionar o usuario de id "2"
                Então eu deverei ver o botao "Salvar"
                    E eu deverei ver o botao "Cancelar"
                Quando eu clicar em "Salvar"
                    Então eu deverei estar em "Lista de atividades em grupo"
                        E eu deverei ver "Grupo salvo com sucesso"
                        E eu deverei ver "Atividade em grupo I"
                     Quando eu clicar no item "Atividade em grupo I"
                        Então eu deverei ver "grupo1.2 tI"
                            E eu deverei ver "Aluno 1"
                            E eu deverei ver "Aluno 2"
                            E eu deverei ver "Aluno 3"

@javascript
Cenário: Edição de grupo com confirm Ok
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Dado que eu preenchi "group_assignment_group_name" com "grupo1.2 tI"
            Então eu deverei ver os alunos do grupo com id "1" selecionados
        Quando eu clicar no grupo "2"
            Então eu deverei ver "Aluno 3"
                E eu deverei ver "Usuario do sistema"
            Quando eu selecionar o usuario de id "2"
                Então eu deverei ver "grupo2 tI"
                E eu deverei ver o link "edit_2"
            Quando eu clicar no link "edit_2"
                E eu clicar em "Ok" no popup
                    Então eu deverei estar em "Edicao do grupo2 tI"
                    E eu deverei ver "Grupo salvo com sucesso"
                    E eu deverei ver "grupo1.2 tI"
                        E eu deverei ver "Aluno 1"
                        E eu deverei ver "Aluno 2"
                        E eu deverei ver "Aluno 3"
                    E eu deverei ver "grupo2 tI"
                        E eu deverei ver "Usuario do Sistema"

@javascript
Cenário: Edição de grupo com confirm Cancel
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clicar no link "Editar"
        Dado que eu preenchi "group_assignment_group_name" com "grupo1.2 tI"
            Então eu deverei ver os alunos do grupo com id "1" selecionados
        Quando eu clicar no grupo "2"
            Então eu deverei ver "Aluno 3"
                E eu deverei ver "Usuario do sistema"
            Quando eu selecionar o usuario de id "2"
                Então eu deverei ver "grupo2 tI"
                E eu deverei ver o link "edit_2"
            Quando eu clicar no link "edit_2"
                E eu clicar em "Cancelar" no popup
                    Então eu deverei estar em "Edicao do grupo2 tI"
                    E eu nao deverei ver "Grupo salvo com sucesso"
                    E eu nao deverei ver "grupo1.2 tI"
                    E eu deverei ver "grupo1 tI"
                        E eu deverei ver "Aluno 1"
                        E eu deverei ver "Aluno 2"
                    E eu deverei ver "grupo2 tI"
                        E eu deverei ver "Aluno 3"
                        E eu deverei ver "Usuario do Sistema"
        
@javascript
Cenário: Acessar página de exclusão de grupo
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            Então eu deverei ver "grupo1 tI"
                E eu deverei ver o link "delete_1"

@javascript
Cenário: Confirmando edição e exclusão de grupo 
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver "grupo1 tI"
            E eu deverei ver o link "delete_1"
        Quando eu clicar no link "delete_1"
            E eu clicar em "Ok" no popup
            #Então eu deverei ver "Grupo salvo com sucesso"
        Quando eu clicar em "Ok" no popup
            Então eu deverei estar em "Lista de atividades em grupo"
            E eu deverei ver "Grupo excluído com sucesso"
        Quando eu clicar no item "Atividade em grupo I"
            Então eu nao deverei ver "grupo1 tI"

@javascript
Cenário: Confirmando edição e cancelando exclusão de grupo 
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver "grupo1 tI"
            E eu deverei ver o link "delete_1"
        Quando eu clicar no link "delete_1"
            E eu clicar em "Ok" no popup
            E eu clicar em "Cancelar" no popup
                Então eu deverei ver "Grupo salvo com sucesso"
                E eu nao deverei ver "Grupo excluído com sucesso"
                E eu deverei estar em "Edicao do grupo1 tI"

@javascript
Cenário: Cancelando edição e confirmando exclusão de grupo 
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver "grupo1 tI"
            E eu deverei ver o link "delete_1"
        Quando eu clicar no link "delete_1"
            E eu clicar em "Cancelar" no popup
            E eu clicar em "Ok" no popup
                Então eu nao deverei ver "Grupo salvo com sucesso"
                E eu deverei estar em "Lista de atividades em grupo"
                E eu deverei ver "Grupo excluído com sucesso"
            Quando eu clicar no item "Atividade em grupo I"
                Então eu nao deverei ver "grupo1 tI"

@javascript
Cenário: Cancelando edição e cancelando exclusão de grupo 
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver "grupo1 tI"
            E eu deverei ver o link "delete_1"
        Quando eu clicar no link "delete_1"
            E eu clicar em "Cancelar" no popup
            E eu clicar em "Cancelar" no popup
                Então eu nao deverei ver "Grupo salvo com sucesso"
                E eu nao deverei ver "Grupo excluído com sucesso"
                E eu deverei estar em "Edicao do grupo1 tI"

@javascript
Cenário: Botão de cancelar na página de edição 
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        Então eu deverei ver "grupo1 tI"
            E eu deverei ver o link "Editar"
    Quando eu clico no link "Editar"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver o botao "Cancelar"
        Quando eu clicar em "Cancelar"
            Então eu deverei estar em "Lista de atividades em grupo"

@javascript
Cenário: Botão de cancelar na página de criação
    Dado que estou logado com o usuario "prof" e com a senha "123456"
        E que estou em "Meu Solar"
    Quando eu clicar no link "Quimica I"
        Então eu deverei ver "Atividades"
    Quando eu clicar no link "Atividades"
        Então eu deverei ver o link "Grupos"
    Quando eu clicar no link "Grupos"
        Então eu deverei ver "Atividade em grupo I"
    Quando eu clicar no item "Atividade em grupo I"
        E eu deverei ver o botao "Novo grupo"
    Quando eu clicar em "Novo grupo"
        Então eu deverei ver "Grupos da atividade Atividade em grupo I"
            E eu deverei ver o botao "Cancelar"
        Quando eu clicar em "Cancelar"
            Então eu deverei estar em "Lista de atividades em grupo"

