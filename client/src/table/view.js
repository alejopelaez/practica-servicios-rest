url = "http://127.0.0.1:9292"
jQuery.extend({
    View: function($buttons, $buttons2, $dataOutput){
	/**
	 * Referencia a uno mismo (Truco!!)
	 */
	var self = this;
	
	/**
	 * Arreglo con los listeners de esta vista.
	 */
	var listeners = new Array();
	
	/**
	 * Se añade un listener a esta vista.
	 */
	this.addListener = function(list){
	    listeners.push(list);
	}

	/**
	 * Pega los botones y campos para crear un nuevo centro.
	 */
	$buttons.html($("<h3>Crear</h3><input id='center_id_n' type = 'text' name = 'name'/> center id<br/><input id='n_jojoy' type = 'text' name = 'name'/>Jojoy<br/><input id='n_reyes' type = 'text' name = 'name'/>Reyes<br/><input id='n_piedad' type = 'text' name = 'name'/>Piedad<br/><br/>"));

	$buttons.append($("<input type='button' value='Create'></input><br><br>").click(function(){
	    params = new Object();
	    params.center_id = $("#center_id_n").val();
	    params.jojoy = $("#n_jojoy").val();
	    params.reyes = $("#n_reyes").val();
	    params.piedad = $("#n_piedad").val();
	    self.viewCreate(params);
	}));

	$buttons2.html($("<h3>Leer (ingresar id)</h3><input id='table_id_r' type = 'text' name = 'name'/> id<br/>"));
	$buttons2.append($("<input id='center_id_r' type = 'text' name = 'name'/> Center id<br/>"));
	$buttons2.append($("<input id='jojoy_r' type = 'text' name = 'name'/> Jojoy<br/>"));
	$buttons2.append($("<input id='reyes_r' type = 'text' name = 'name'/> Reyes<br/>"));
	$buttons2.append($("<input id='piedad_r' type = 'text' name = 'name'/> Piedad<br/>"));
	$buttons2.append($("<input type='button' value='Load'></input>").click(function(){
	    self.viewLoadSingle($("#table_id_r").val());
	}));
	$buttons2.append($("<input type='button' value='Modify'></input>").click(function(){
	    params = new Object();
	    params.id = $("#table_id_r").val();
	    params.center_id = $("#center_id_r").val();
	    params.jojoy = $("#jojoy_r").val();
	    params.reyes = $("#reyes_r").val();
	    params.piedad = $("#piedad_r").val();
	    self.viewModify(params);
	}));
	$buttons2.append($("<input type='button' value='Delete'></input><br><br>").click(function(){
	    id = $("#table_id_r").val();
	    self.viewDelete(id);
	}));

	this.createTable = function(data){	    
	    html = "<table>";
	    html += "<tr><th>id</th><th>Jojoy</th><th>Reyes</th><th>Piedad</th><th>Center id</th></tr>";
	    console.log(data);
	    for(i in data){
		c = data[i];
		html += "<tr>";
		html += "<td>"+c.id+"</td>";
		html += "<td>"+c.jojoy+"</td>";
		html += "<td>"+c.reyes+"</td>";
		html += "<td>"+c.piedad+"</td>";
		html += "<td>"+c.center_id+"</td>";
		html += "</tr>";
	    }

	    html += "</table>";
	    $dataOutput.html(html);
	}

	this.loadSingleEnd = function(data){
	    $("#center_id_r").val(data.center_id);
	    $("#jojoy_r").val(data.jojoy);
	    $("#reyes_r").val(data.reyes);
	    $("#piedad_r").val(data.piedad);
	}

	/**
	 * Funcion dummy
	 */
	this.viewLoadData = function(){
	    for(i in listeners)
		listeners[i].viewLoadData();
	}
	this.viewCreate = function(params){
	    for(i in listeners)
		listeners[i].viewCreate(params);
	}
	this.viewLoadSingle = function(id){
	    for(i in listeners)
		listeners[i].viewLoadSingle(id);
	}
	this.viewModify = function(params){
	    for(i in listeners)
		listeners[i].viewModify(params);
	}
	this.viewDelete = function(id){
	    for(i in listeners)
		listeners[i].viewDelete(id);
	}
    },
    /**
     * Funcion para crear listener de la vista facilmente.
     */
    ViewListener: function(list) {
	if(!list) list = {};
	return $.extend({
	    viewLoadData : function(){},
	    viewLoadSingle : function(id){},
	    viewModify : function(params){},
	    viewDelete : function(id){},
	    viewCreate : function(params){}
	}, list);
    }
    
});