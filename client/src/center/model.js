jQuery.extend({
    Model: function(){
        /**
         * referencia a nosotros (truco!!)
         */
        var self = this;
        /**
         * listeners del modelo
         */
        var listeners = new Array();
        /**
         * load lots of data from the server
         * or return data from cache if it's already
         * loaded
         */
        this.loadData = function(){
	    $.getJSON("http://127.0.0.1:9292/center.json"+"?callback=?", function(data) {
		self.onLoadEnd(data);
	    });
        }

	this.loadSingle = function(id){
	    $.getJSON("http://127.0.0.1:9292/center/"+id+".json?callback=?", function(data) {
		self.loadSingleEnd(data);
	    });
	}

        /**
         * Añade un listener
         */
        this.addListener = function(list){
            listeners.push(list);
        }

        /**
         * Función que se llama en los listeners
         * del modelo cuando se empieza a cargar.
         */
        this.onLoadBegin = function(){
            $.each(listeners, function(i){
                listeners[i].onLoadBegin();
            });
        }
        /**
         * Función que se llama en los listeners
         * del modelo cuando se termina de cargar.
         */
        this.onLoadEnd = function(result){
            $.each(listeners, function(i){
                listeners[i].onLoadEnd(result);
            });
        }
        this.loadSingleEnd = function(result){
            $.each(listeners, function(i){
                listeners[i].loadSingleEnd(result);
            });
        }

	this.modify = function(params){
	    $.post(url+"/center",{id: params.id, name: params.nombre, city_id: params.city_id, method : "PUT"});
	    self.loadData();
	}

	this.mdelete = function(id){
	    $.post(url+"/center/"+id,{method: "DELETE"});
	    self.loadData();
	}
    },

    /**
     * Funcion para crear un listener del modelo facilmente.
     */
    ModelListener: function(list) {
        if(!list) list = {};
        return $.extend({
            onLoadBegin : function(){},
            onLoadEnd : function(info){},
	    loadSingleEnd : function(info){}
        }, list);
    }
});