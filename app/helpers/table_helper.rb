module TableHelper
  
  def table(data, attributes={})
    table = "<table class=\"#{attributes[:class]}\">"
    data.each do |row|
      table = "#{table}<tr class=\"#{attributes[:tr_class]}\">"
      row.each do |cell|
        table = "#{table}<td class=\"#{attributes[:td_class]}\">#{cell}</td>"
      end
      table = "#{table}</tr>"
    end
    table = "#{table}</table>"  
    end
end