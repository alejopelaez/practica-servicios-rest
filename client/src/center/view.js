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
//	$buttons.append($("<form name='input' action='http://127.0.0.1:9292/center' method='post' target = '_self'>city_id: <input type='text' name='city_id'/><br/>nombre: <input type = 'text' name = 'name'/><br/><input id='create_but' type='submit' value='Crear'/></form>"));
	$buttons.html($("<h3>Crear</h3><input id='city_id' type = 'text' name = 'name'/> city id<br/><input id='center_name' type = 'text' name = 'name'/>nombre<br/><br/>"));

	$buttons.append($("<input type='button' value='Create'></input><br><br>").click(function(){
	    id = $("#city_id").val();
	    nombre = $("#center_name").val();
	    $.post(url+"/center",{name:nombre, city_id:id});
	    self.viewLoadData();
	}));

	$buttons2.html($("<h3>Leer (ingresar id)</h3><input id='center_id_r' type = 'text' name = 'name'/> id<br/>"));
	$buttons2.append($("<input id='center_name_r' type = 'text' name = 'name'/> name<br/>"));
	$buttons2.append($("<input id='city_id_r' type = 'text' name = 'name'/> city id<br/><br/>"));
	$buttons2.append($("<input type='button' value='Load'></input>").click(function(){
	    self.viewLoadSingle($("#center_id_r").val());
	}));
	$buttons2.append($("<input type='button' value='Modify'></input>").click(function(){
	    params = new Object();
	    params.id = $("#center_id_r").val();
	    params.name = $("#center_name_r").val();
	    params.city_id = $("#city_id_r").val();
	    self.viewModify(params);
	}));
	$buttons2.append($("<input type='button' value='Delete'></input><br><br>").click(function(){
	    id = $("#center_id_r").val();
	    self.viewDelete(id);
	}));

	this.createTable = function(data){
	    html = "<table>";
	    html += "<tr><th>id</th><th>Nombre</th><th>city id</th></tr>";
	    for(i in data){
		c = data[i].center;
		html += "<tr>";
		html += "<td>"+c.id+"</td>";
		html += "<td>"+c.name+"</td>";
		html += "<td>"+c.city_id+"</td>";
		html += "</tr>";
	    }

	    html += "</table>";
	    $dataOutput.html(html);
	}

	this.loadSingleEnd = function(data){
	    $("#city_id_r").val(data.city_id);
	    $("#center_name_r").val(data.name);
	}

	/**
	 * Funcion dummy
	 */
	this.viewLoadData = function(){
	    for(i in listeners)
		listeners[i].viewLoadData();
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
	    viewDelete : function(id){}
	}, list);
    }
    
});