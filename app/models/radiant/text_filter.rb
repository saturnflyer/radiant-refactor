module Radiant
  class TextFilter
    extend Radiant::Simpleton
  
    class_attribute :filter_name, :description
   
    def filter(text)
      text
    end
  
    class << self
      def inherited(subclass)
        subclass.filter_name = subclass.filter_name
      end
    
      def filter_name
        @filter_name ||= name.to_s.underscore.gsub('/', ' ').humanize.titlecase.gsub(/Filter/,'')
      end
    
      def filter(text)
        instance.filter(text)
      end
    
      def description_file(filename)
        text = File.read(filename) rescue ""
        self.description text
      end

      def descendants_names
        descendants.map { |s| s.filter_name }.sort
      end

      def find_descendant(filter_name)
        descendants.each do |s|
          return s if s.filter_name == filter_name
        end
        nil
      end
    end
  end
end