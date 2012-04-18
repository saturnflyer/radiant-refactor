class HomePageDataset < Dataset::Base
  
  def load
    create_page "Home", :slug => "/", :parent_id => nil do
      create_page_part "body", :content => "Hello world!"
      create_page_part "sidebar", :content => "<r:title /> sidebar."
      create_page_part "extended", :content => "Just a test."
      create_page_part "titles", :content => "<r:title /> <r:page:title />"
    end
  end
  
  helpers do
    def create_page(name, attributes={})
      attributes = page_params(attributes.reverse_merge(:title => name))
      body = attributes.delete(:body) || name
      symbol = name.to_sym
      create_record 'Radiant::Page', symbol, attributes
      if block_given?
        old_page_id = @current_page_id
        @current_page_id = page_id(symbol)
        yield
        @current_page_id = old_page_id
      end
      if pages(symbol).parts.empty?
        create_page_part "#{name}_body".to_sym, :name => "body", :content => body + ' body.', :page_id => page_id(symbol)
      end
    end
    def page_params(attributes={})
      title = attributes[:title] || unique_page_title
      attributes = {
        :title => title,
        :breadcrumb => title,
        :slug => title.to_s.gsub("_", "-"),
        :class_name => nil,
        :status_id => Radiant::Status[:published].id,
        :published_at => Time.now.to_s(:db)
      }.update(attributes)
      attributes[:parent_id] = @current_page_id || page_id(:home) unless attributes.has_key?(:parent_id)
      attributes
    end
    
    def create_page_part(name, attributes={})
      attributes = page_part_params(attributes.reverse_merge(:name => name))
      create_record "Radiant::PagePart", name.to_sym, attributes
    end
    def page_part_params(attributes={})
      name = attributes[:name] || "unnamed"
      attributes = {
        :name => name,
        :content => name,
        :page_id => @current_page_id
      }.update(attributes)
    end
    
    private
      def unique_page_title
        @@unique_page_title_call_count ||= 0
        @@unique_page_title_call_count += 1
        "Page #{@@unique_page_title_call_count}"
      end
  end
end