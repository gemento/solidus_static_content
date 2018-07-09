Deface::Override.new(virtual_path:  "spree/admin/shared/_settings_sub_menu",
                     name:          "pages_admin_configurations_menu",
                     insert_bottom: "[data-hook='admin_settings_sub_tabs']",
                     text:          "<%= tab :pages, url: admin_pages_path %>",
                     disabled:      false)
