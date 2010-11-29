url = "http://127.0.0.1"
jQuery.extend({
    View: function($buttons, $dataOutput){
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
	$buttons.append($("<form name='input' action='http://127.0.0.1:9292/center' method='post' target = '_self'>city_id: <input type='text' name='city_id'/><br/>nombre: <input type = 'text' name = 'name'/><br/><input onclick='view.create_but' type='submit' value='Crear'/></form>"));

	this.create_but = function(){
	    alert("hola");
	}

	this.createTable = function(data){
	    html = "<table>";
	    html += "<tr><th>id</th><th>Nombre</th><th>city id</th></tr>";
	    for(i in data){
		c = data[i];
		html += "<tr>";
		html += "<td>"+c.id+"</td>";
		html += "<td>"+c.name+"</td>";
		html += "<td>"+c.city_id+"</td>";
		html += "<td><button type='button'>Delete</button></td>";
		html += "</tr>";
	    }

	    html += "</table>";
	    $dataOutput.html(html);
	}

	/**
	 * Funcion dummy
	 */
	this.viewLoadData = function(){
	}
    },
    /**
     * Funcion para crear listener de la vista facilmente.
     */
    ViewListener: function(list) {
	if(!list) list = {};
	return $.extend({
	    viewLoadData : function(){}
	}, list);
    }
    
});