class CreateRadiantTables < ActiveRecord::Migration
  def up
    create_table Radiant.prefixed_table_name('config'), :force => true do |t|
      t.string "key",   :limit => 40, :default => "", :null => false
      t.string "value",               :default => ""
    end

    add_index Radiant.prefixed_table_name('config'), ["key"], :name => "key", :unique => true

    create_table Radiant.prefixed_table_name('page_fields'), :force => true do |t|
      t.integer "page_id"
      t.string  "name"
      t.string  "content"
    end

    add_index Radiant.prefixed_table_name('page_fields'), ["page_id", "name", "content"], :name => "index_page_fields_on_page_id_and_name_and_content"

    create_table Radiant.prefixed_table_name('page_parts'), :force => true do |t|
      t.string  "name",      :limit => 100
      t.string  "filter_id", :limit => 25
      t.text    "content"
      t.integer "page_id"
    end

    add_index Radiant.prefixed_table_name('page_parts'), ["page_id", "name"], :name => "parts_by_page"

    create_table Radiant.prefixed_table_name('pages'), :force => true do |t|
      t.string   "title"
      t.string   "slug",                   :limit => 100
      t.string   "breadcrumb",             :limit => 160
      t.string   "class_name",             :limit => 25
      t.integer  "status_id",                              :default => 1,     :null => false
      t.integer  "parent_id"
      t.integer  "layout_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "published_at"
      t.integer  "created_by_id"
      t.integer  "updated_by_id"
      t.boolean  "virtual",                                :default => false, :null => false
      t.integer  "lock_version",                           :default => 0
      t.text     "allowed_children_cache", :limit => 1500, :default => ""
    end

    add_index Radiant.prefixed_table_name('pages'), ["class_name"], :name => "altered_pages_class_name"
    add_index Radiant.prefixed_table_name('pages'), ["parent_id"], :name => "altered_pages_parent_id"
    add_index Radiant.prefixed_table_name('pages'), ["slug", "parent_id"], :name => "altered_pages_child_slug"
    add_index Radiant.prefixed_table_name('pages'), ["virtual", "status_id"], :name => "altered_pages_published"

    create_table "radiant_layouts", :force => true do |t|
      t.string   "name",          :limit => 100
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "created_by_id"
      t.integer  "updated_by_id"
      t.string   "content_type",  :limit => 40
      t.integer  "lock_version",                 :default => 0
    end
  end

  def down
    remove_index Radiant.prefixed_table_name('pages'), ["virtual", "status_id"]
    remove_index Radiant.prefixed_table_name('pages'), ["slug", "parent_id"]
    remove_index Radiant.prefixed_table_name('pages'), ["parent_id"]
    remove_index Radiant.prefixed_table_name('pages'), ["class_name"]
    remove_index Radiant.prefixed_table_name('page_parts'), ["page_id", "name"]
    remove_index Radiant.prefixed_table_name('page_fields'), ["page_id", "name", "content"]
    remove_index Radiant.prefixed_table_name('config'), ["key"]
    drop_table Radiant.prefixed_table_name('page_fields')
    drop_table Radiant.prefixed_table_name('page_parts')
    drop_table Radiant.prefixed_table_name('pages')
  end
end
