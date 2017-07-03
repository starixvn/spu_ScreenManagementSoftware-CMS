var xiboNexcel = {
    domElements: {
        pageWrapper: null,
        sidebarWrapper: null,
        sidebar: null,
        sidebarMenuTitle: null,
        sidebarMenuItem: null, 
        colexpIcon: null, 
        submenuItem: null,
        menuTitleCollapse: null
    }, 

    init: function() {
        xiboNexcel.storeElements();
        xiboNexcel.bindEvents();
    },

    storeElements: function() {
        xiboNexcel.domElements.pageWrapper = $('#page-wrapper');
        xiboNexcel.domElements.sidebarWrapper = $('#sidebar-wrapper');
        xiboNexcel.domElements.sidebar = $('.sidebar');
        xiboNexcel.domElements.sidebarMenuItem = $('.menu-item');
        xiboNexcel.domElements.sidebarMenuTitle = $('.menu-title');
        xiboNexcel.domElements.sidebarMenuItem = $('.sub-menu');
        xiboNexcel.domElements.colexpIcon = $('.colexp');
        xiboNexcel.domElements.submenuItem = $('.sidebar-list');
        xiboNexcel.domElements.menuTitleCollapse = $('.menu-title.collapse');
        
    }, 

    bindEvents: function() {
        $('.collapse').collapse();

        xiboNexcel.domElements.colexpIcon.click(function(e){
            if(!xiboNexcel.domElements.pageWrapper.hasClass('collapsed')){
                xiboNexcel.domElements.pageWrapper.addClass('collapsed');
                xiboNexcel.domElements.sidebarMenuTitle.removeAttr('data-toggle');
                xiboNexcel.domElements.menuTitleCollapse.removeClass('hidden').addClass('show');

            }
            else {
                xiboNexcel.domElements.pageWrapper.removeClass('collapsed');
                xiboNexcel.domElements.sidebarMenuTitle.attr('data-toggle', 'collapse');
                 xiboNexcel.domElements.menuTitleCollapse.removeClass('show').addClass('hidden');
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

    }

};

$(function () {
    xiboNexcel.init();
});
