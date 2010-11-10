module ApplicationHelper
	
	def get_bread_crumbs(url)
		
	
		
		#home_uri = "/projects/"
		#project_name = Project.find(session[:project_id], :select="title")
		#project_uri = "/projects/" + session[:project_id]
		return  url
	end
	
	
	def get_bread_crumb2(url)
	  begin
	    breadcrumb = ''
	    sofar = '/'
	    elements = url.split('/')
	    for i in 1...elements.size
	      sofar += elements[i] + '/'
	      if i%2 == 0
	        begin
	          breadcrumb += "<a href='#{sofar}'>"  + eval("#{elements[i - 1].singularize.camelize}.find(#{elements[i]}).name").to_s + '</a>'
	        rescue
	          breadcrumb += elements[i]
	        end
	      else
	        breadcrumb += "<a href='#{sofar}'>#{elements[i].pluralize}</a>"
	      end
	      breadcrumb += ' -> ' if i != elements.size - 1
	    end
	    breadcrumb
	  rescue
	    'Not available'
	  end
	end
end
