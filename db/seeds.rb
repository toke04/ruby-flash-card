# frozen_string_literal: true

# for_development_environment
# User.create([
#               name: ENV['ADMIN_NAME'],
#               provider: 'github',
#               uid: ENV['ADMIN_UID'],
#               image: ENV['ADMIN_IMAGE'],
#               admin: true
#             ])

module_names = %w[Enumerable Array Hash String Numeric Range]

module_names.each do |module_name|
  RubyModule.create([
                      name: module_name
                    ])
end

ruby_module_ids = RubyModule.all.order(id: 'ASC').pluck(:id)

# rubocop:disable Layout/LineLength
enumerable_methods = %w[collect_concat each_cons each_entry each_slice each_with_index each_with_object entries filter_map find find_all flat_map grep grep_v group_by inject max_by min_by minmax minmax_by partition reduce reject reverse_each slice_after slice_before slice_when sort_by take take_while tally]

array_methods = %w[append assoc at clear clone collect compact concat count delete delete_at delete_if difference dig drop drop_while dup each_index fetch fill filter find_index flatten hash index insert inspect intersection join keep_if max min minmax pop prepend product push reject replace reverse_each rindex rotate sample select shift shuffle size slice sort sum take take_while transpose union uniq unshift values_at zip]

hash_methods = %w[assoc clear clone compact delete delete_if dig dup each_key each_pair each_value except fetch fetch_values filter flatten hash inspect invert keep_if key keys length merge rehash reject replace select shift size slice store transform_keys transform_values update values values_at]

string_methods = %w[byteindex byteslice capitalize casecmp center chars chomp chop chr concat count delete delete_prefix delete_suffix downcase dump each_char each_line gsub index insert inspect length lines ljust lstrip match next partition prepend replace rindex rjust rpartition rstrip scan slice split squeeze strip sub swapcase tr tr_s undump upcase upto]

numeric_methods = %w[abs abs2 ceil div divmod fdiv quo remainder round step truncate]

range_methods = %w[begin end inspect size step]
# rubocop:enable Layout/LineLength

def create_url(module_name, method_name)
  if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html")).code == '200'
    "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{method_name}.html"
  else
    "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{method_name.upcase.slice(/[^?]+/)}--3F"
  end
end

def create_method(method_name, module_id, module_name)
  RubyMethod.create([
                      name: method_name,
                      ruby_module_id: module_id,
                      official_url: create_url(module_name, method_name)
                    ])
end

enumerable_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[0], module_names[0])
end

array_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[1], module_names[1])
end

hash_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[2], module_names[2])
end

string_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[3], module_names[3])
end

numeric_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[4], module_names[4])
end

range_methods.each do |method_name|
  create_method(method_name, ruby_module_ids[5], module_names[5])
end
