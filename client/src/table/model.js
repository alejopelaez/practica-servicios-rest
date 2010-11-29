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
	    $.getJSON("http://127.0.0.1:9292/table.json"+"?callback=?", function(data) {
		self.onLoadEnd(data);
	    });
        }

	this.loadSingle = function(id){
	    $.getJSON("http://127.0.0.1:9292/table/"+id+".json?callback=?", function(data) {
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

	this.create = function(params){
	    $.post(url+"/table.json",{name: params.name, center_id: params.center_id, jojoy : params.jojoy, reyes : params.reyes, piedad : params.piedad});
	    self.loadData();
	}

	this.modify = function(params){
	    $.post(url+"/table.json",{id: params.id, center_id: params.center_id, jojoy : params.jojoy, reyes : params.reyes, piedad : params.piedad, method : "PUT"});
	    self.loadData();
	}

	this.mdelete = function(id){
	    $.post(url+"/table/"+id+".json",{method: "DELETE"});
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