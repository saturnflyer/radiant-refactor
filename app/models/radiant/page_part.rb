class Radiant::PagePart < ActiveRecord::Base
  
  # Associations
  belongs_to :page
  
  # Validations
  validates_presence_of :name
  validates_length_of :name, :maximum => 100
  validates_length_of :filter_id, :maximum => 25, :allow_nil => true
  
  def filter
    if @filter.blank? || @old_filter != @filter
      @old_filter = @filter
      klass = Radiant::TextFilter.descendants.find { |descendant| descendant.filter_name == filter_id }
      klass ||= Radiant::TextFilter
      @filter_id = klass.new
    else
      @filter
    end
  end

  def after_initialize
    self.filter_id ||= Radiant::Config['defaults.page.filter'] if new_record?
  end

end
