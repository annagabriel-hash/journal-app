module ApplicationHelper
  def convert_to_propercase(string)
    arr_of_str = string.split(' ')
    arr_of_str.map! { |word| word.capitalize }
    arr_of_str.join(' ')
  end
end
