$(document).ready(function(){
	$("#offerPanel").css('width','0px');
	$("#groupPanel").css('width','0px');
	$("#curricularUnitPanel").css('width','100%');
	loadCurriculum_Units();

	//Tratando a seleção de unidade curricular
	$("#curricularUnitPanel li").live("click", function(){ pickCurriculum_Units(this); });
	//Tratando a seleção de ofertas
	$("#offerPanel li").live("click", function(){ pickOffer(this); });
	//Tratando a seleção de turmas
	$("#groupPanel li").live("click", function(){ markSelected(this);});

});

function getComponentWidth(){
	return $(".allocationTagPicker").width();
}

/****************************************
* Marca o item selecionado
* */
function markSelected(element){
	$('#PickedAllocationTagId').val(getAllocationTagId($(element).attr('id')));
	$(element).siblings().removeClass('selected');
	$(element).siblings().removeClass('light');
	$(element).removeClass('light');
	$(element).removeClass('selected');
	
	$('.selected').addClass('light');
	$(element).addClass('selected');
	$(element).siblings().clearQueue();
	$(element).siblings().animate({
	    opacity: 0.5
	}, 300);
	$(element).animate({
	    opacity: 1.0
	}, 300);
}

/****************************************
* Atualiza a lista de unidades curriculares por ajax.
* */
function loadCurriculum_Units(){
    var type = 'get';
    var url = '../components/fill_curriculum_units';
    var selector = "";
    var target = $("#curricularUnitPanel");
    
    var params = '';
    // Request the remote document
    jQuery.ajax({
        url: url,
        type: type,
        dataType: "html",
        data: params,//params,
        complete: function( jqXHR, status, responseText ) {
            responseText = jqXHR.responseText;
            target.html(responseText);
        }
    });
    return false;
}

function pickCurriculum_Units(element){
    markSelected(element);
    
	//calculando a largura de uma coluna: (1/3 do total)
	var defaultColunmWidth = Math.floor(getComponentWidth()/3);
	$('#curricularUnitPanel').clearQueue();
	$('#offerPanel').clearQueue();
	$('#groupPanel').clearQueue();
	
	$('#curricularUnitPanel').animate({
	    width: defaultColunmWidth*2 + 'px'
	}, 300);
	$('#offerPanel').animate({
		opacity: 0.25,
	    width: defaultColunmWidth + 'px'
	}, 300);
	$('#groupPanel').animate({
	    width: '0px'
    }, 300);

	loadOffers();
	
	return false;
}

function pickOffer(element){
    markSelected(element);
	//calculando a largura de uma coluna: (1/3 do total)
	var defaultColunmWidth = Math.floor(getComponentWidth()/3);

	$('#curricularUnitPanel').clearQueue();
	$('#offerPanel').clearQueue();
	$('#groupPanel').clearQueue();

	$('#curricularUnitPanel').animate({
	    width: defaultColunmWidth + 'px'
	}, 300);
	$('#groupPanel').animate({
		opacity: 0.25,
	    width: defaultColunmWidth + 'px'
    }, 300);

    loadGroups();
	return false;
}


/****************************************
* Atualiza a lista de ofertas por ajax.
* */
function loadOffers(){
    var type = 'get';
    var url = '../components/fill_offers';
    var target = $("#offerPanel");
    var params = '';
    var selected = getEntityId($("#curricularUnitPanel li.selected").attr('id'));
    params += 'unit_id=' + selected

    // Requisição remota
    jQuery.ajax({
        url: url,
        type: type,
        dataType: "html",
        data: params,
        complete: function( jqXHR, status, responseText ) {
            responseText = jqXHR.responseText;
            target.html(responseText);
            target.fadeTo(300,1.0);
        }
    });
    return false;
}

/****************************************
* Atualiza a lista de turmas por ajax.
* */
function loadGroups(){
    var type = 'get';
    var url = '../components/fill_groups';
    var target = $("#groupPanel");
    var params = '';
    var selected = getEntityId($("#offerPanel li.selected").attr('id'));
    params += 'offer_id=' + selected

    // Requisição remota
    jQuery.ajax({
        url: url,
        type: type,
        dataType: "html",
        data: params,
        complete: function( jqXHR, status, responseText ) {
            responseText = jqXHR.responseText;
            target.html(responseText);
            target.fadeTo(300,1.0);
        }
    });
    return false;
}

/****************************************
* Recupera ID da turma, oferta ou uc de um elemento da lista com base em seu id
* */
function getEntityId(selected){
	selected = selected.substr(selected.indexOf('_')+1);
    selected = selected.substr(0,selected.indexOf('#'));
    return selected;
}

/****************************************
* Recupera AllocationTagId de um elemento da lista com base em seu id
* */
function getAllocationTagId(selected){
	return selected.substr(selected.indexOf('#')+1);
}