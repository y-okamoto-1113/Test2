module ApplicationHelper
  def sortable(column, title = nil, style='')   # 第１引数は並び替え元となるデータベース上のテーブルのカラム名、第２引数はViewに表示するカラム名
    # binding.pry
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class, :style => style}
  end
end
