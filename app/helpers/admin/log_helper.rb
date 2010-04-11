module Admin::LogHelper
  def linked_item_name(entry)
    if entry.source_id
      link_to "#{entry.item_type} #{entry.source_id}", "#{entry.table.pluralize}/#{entry.source_id}"
    else
      "#{entry.item_type}" 
    end
  end
end
