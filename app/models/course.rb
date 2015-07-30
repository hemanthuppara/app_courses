require 'active_resource'

class Course < ActiveResource::Base
   self.site  = I18n.t("canvas_url")+I18n.t('courses')
end