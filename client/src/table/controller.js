jQuery.extend({
    Controller: function(model, view){
        /**
         * Escucha a la vista
         */
        var vlistener = $.ViewListener({
            viewLoadData : function(){
		model.loadData();
            },
	    viewLoadSingle : function(id){
		model.loadSingle(id);
	    },
	    viewCreate : function(params){
		model.create(params);
	    },
	    viewModify : function(params){
		model.modify(params);
	    },
	    viewDelete : function(id){
		model.mdelete(id);
	    }
        });
        view.addListener(vlistener);
	

        /**
         * listen to the model
         */
        var mlist = $.ModelListener({
            onLoadBegin : function(){                
            },
            onLoadEnd : function(info){
		view.createTable(info);
            },
	    loadSingleEnd : function(info){
		view.loadSingleEnd(info);
	    }
        });
        model.addListener(mlist);
    }
});