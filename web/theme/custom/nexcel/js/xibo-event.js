var xiboNexcel = {
    domElements: {
        sidebarWrapper: null,
        sidebar: null,
        sidebarMenuTitle: null,
        sidebarMenuItem: null, 
        colexpIcon: null, 
        submenuItem: null,
    }, 

    init: function() {
        xiboNexcel.storeElements();
        xiboNexcel.bindEvents();
    },

    storeElements: function() {
        xiboNexcel.domElements.sidebarWrapper = $('#sidebar-wrapper');
        xiboNexcel.domElements.sidebar = $('.sidebar');
        xiboNexcel.domElements.sidebarMenuItem = $('.menu-item');
        xiboNexcel.domElements.sidebarMenuTitle = $('.menu-title');
        xiboNexcel.domElements.sidebarMenuItem = $('.sub-menu');
        xiboNexcel.domElements.colexpIcon = $('.colexp');
        xiboNexcel.domElements.submenuItem = $('.sidebar-list');
    }, 

    bindEvents: function() {
        xiboNexcel.domElements.sidebarMenuTitle.click(function(e){
            $this = $(this);
            if($this.hasClass('collapsed')) {
                $this.next().slideDown('fast');
                $this.removeClass('collapsed');
            }
            else {
                 $this.next().slideUp('fast');
                $this.addClass('collapsed');
            }
            
        });

        xiboNexcel.domElements.colexpIcon.click(function(e){
            if(!xiboNexcel.domElements.sidebarWrapper.hasClass('collapsed')){
                xiboNexcel.domElements.sidebarWrapper.addClass('collapsed');
                xiboNexcel.sidebarCollpased();
            }
            else {
                xiboNexcel.domElements.sidebarWrapper.removeClass('collapsed');
            }
        });

        xiboNexcel.domElements.submenuItem.hover(
            function(){
                $this = $(this);
                var ele = $this.find('.fa');
                ele.removeClass('fa-circle-o');
                ele.addClass('fa-circle');
            }, 
            function() {
                $this = $(this);
                var ele = $this.find('.fa');
                ele.removeClass('fa-circle');
                ele.addClass('fa-circle-o');
            }
        );
    },

     sidebarCollpased: function() {
        
     }
};

$(function () {
    xiboNexcel.init();
});
